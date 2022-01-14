extends Projectile

var acceleration : float = 1400.0
var max_speed : float = 5000.0
var rotation_speed = 0.3
var target = null


func _physics_process(delta):
	speed = min(speed+delta*acceleration,max_speed)
	if target != null:
		var angle = direction.angle()
		var desired_angle = target.global_position.angle_to_point(global_position)
		var new_angle_dir = sign(fposmod(desired_angle-angle+PI,TAU)-PI)
		direction = direction.rotated(new_angle_dir*rotation_speed*delta)
