extends Boss


var points : Array

var gravity : float = 1000
var p_length : float = 64.4
onready var beard = $Pecinac/Beard
onready var head = $Pecinac/Head


func _init():
	boss_name = "Pećinac 2"
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
