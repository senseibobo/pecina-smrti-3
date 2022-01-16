extends Projectile

var target : Node
var rotation_speed : float = 0.02

func _physics_process(delta):
	if target != null:
		var angle = direction.angle()
		var desired_angle = target.global_position.angle_to_point(global_position)
		var new_angle_dir = sign(fposmod(desired_angle-angle+PI,TAU)-PI)
		direction = direction.rotated(new_angle_dir*rotation_speed*delta)
		rotation = direction.angle()
