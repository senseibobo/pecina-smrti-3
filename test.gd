extends Boss


var points : Array

var gravity : float = 1000
var p_length : float = 64.4
onready var beard = $Pecinac/Beard
onready var head = $Pecinac/Head


func _init():
	boss_name = "Glava Pećine Smrti"
	boss_id = "pecinac"
	phase = 2

func _ready():
	beard.set_as_toplevel(true)
	for i in 6:
		points.append(Vector2())

func _process(delta):
	points[0] = head.global_position + Vector2(-20,86)
	for i in range(1,points.size()):
		points[i].y += gravity*delta
		var last_point = points[i-1] as Vector2
		var point = points[i] as Vector2
		var angle = point.angle_to_point(last_point)
		var dist = point.distance_to(last_point)
		points[i] = last_point+Vector2.RIGHT.rotated(angle)*min(p_length,dist)
	beard.points = PoolVector2Array(points)
	head.rotation = points[0].angle_to_point(points[1]) + PI/2
	
func launch_bloodball(pos : Vector2, rot = null,target = Game.get_player(), prepare: bool = false):
	var bloodball = preload("res://bosses/darko/attacks/first/bloodball.tscn").instance()
	bloodball.global_position = pos
	bloodball.prepare = prepare
	Game.get_world().add_child(bloodball)
	if target != null:
		bloodball.target = target
		if rot == null:	bloodball.launch_towards(target.global_position)
		else:			bloodball.launch_at_angle(rot)
	else:
		if rot == null:	bloodball.direction = Vector2.DOWN
		else:			bloodball.direction = Vector2.RIGHT.rotated(rot)
	Game.shake_screen(10,0.2)
	return bloodball

func create_lasergun(pos,rot,prep,time,scale = Vector2(1,1)):
	var lasergun = preload("res://bosses/darko/attacks/second/lasergun.tscn").instance()
	lasergun.global_position = pos
	lasergun.rotation = deg2rad(rot)
	lasergun.prep = prep
	lasergun.time = time
	lasergun.scale = scale
	Game.get_world().add_child(lasergun)

func death():
	get_tree().change_scene("res://bosses/pecinac/ending.tscn")
	Game.emit_signal("game_finished")
