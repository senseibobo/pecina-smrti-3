extends Trap

export var speed : float = 1800

var moving : bool = false

func _process(delta):
	if moving:
		global_position += Vector2.DOWN.rotated(global_rotation)*speed*delta

func _on_DetectArea_body_entered(_body):
	moving = true

func body_entered(body):
	.body_entered(body)
	speed = 0

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
