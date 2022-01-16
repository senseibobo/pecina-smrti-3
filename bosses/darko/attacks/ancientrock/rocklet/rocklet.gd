extends Projectile

var fall_speed : float = 400

func _physics_process(delta):
	var velocity = direction*speed
	velocity.y += fall_speed*delta
	direction = velocity.normalized()
	speed = velocity.length()
