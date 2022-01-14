extends Node2D


var direction : Vector2
var speed : float = 450

func _process(delta):
	global_position += speed*direction*delta

func launch_towards(pos):
	direction = global_position.direction_to(pos)


func _on_Area2D_body_entered(body):
	body.death()
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
