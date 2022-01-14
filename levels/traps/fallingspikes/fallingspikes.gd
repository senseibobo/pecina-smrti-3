extends Node2D


export var speed : float = 1800

var moving : bool = false

func _process(delta):
	global_position += int(moving)*Vector2.DOWN.rotated(global_rotation)*speed*delta

func _on_DetectArea_body_entered(_body):
	moving = true


func _on_DeathArea_body_entered(body):
	body.death()
	speed = 0
	
func trigger():
	moving = true

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
