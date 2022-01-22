extends Node2D


var points : Array

var gravity : float = 1600
var p_length : float = 64.4

func _ready():
	for i in 6:
		points.append(Vector2())

func _process(delta):
	$Head.global_position = get_global_mouse_position()
	points[0] = get_global_mouse_position() + Vector2(-20,86)
	for i in range(1,points.size()):
		points[i].y += gravity*delta
		var last_point = points[i-1] as Vector2
		var point = points[i] as Vector2
		var angle = point.angle_to_point(last_point)
		var dist = point.distance_to(last_point)
		points[i] = last_point+Vector2.RIGHT.rotated(angle)*min(p_length,dist)
	$Line2D.points = PoolVector2Array(points)
	$Head.rotation = points[0].angle_to_point(points[1]) + PI/2
