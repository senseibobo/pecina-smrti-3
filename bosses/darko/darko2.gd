extends Boss


var idle_duration = 1

onready var bhm = get_node("BulletHellManager")

func _init():
	boss_name = "Darko 2"
	boss_id = "darko"
	phase = 2
		
		
func launch_bloodball(pos : Vector2, rot = null,target = Game.get_player()):
	var bloodball = preload("res://bosses/darko/attacks/first/bloodball.tscn").instance()
	bloodball.global_position = pos
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
