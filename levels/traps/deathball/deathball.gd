extends Trap

export var rotation_speed : float = 100

func _process(delta):
	rotation = wrapf(rotation+delta*rotation_speed/30,0,TAU)

func body_entered(body):
	.body_entered(body)
	rotation_speed = 0
