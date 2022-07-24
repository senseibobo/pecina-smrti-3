extends Projectile

var acceleration : float = 1400.0
var max_speed : float = 5000.0
var rotation_speed = 0.3
var target = null
var prepare: bool = false

func _ready():
	if prepare:
		$CollisionShape2D.disabled = true
		moving = false
		modulate.a = 0.6
		yield(Tools.timer(0.3),"timeout")
		$CollisionShape2D.set_deferred("disabled",false)
		modulate.a = 1.0
		moving = true

func _physics_process(delta):
	if not moving: return
	speed = min(speed+delta*acceleration,max_speed)
	if target != null:
		var angle = direction.angle()
		var desired_angle = target.global_position.angle_to_point(global_position)
		var new_angle_dir = sign(fposmod(desired_angle-angle+PI,TAU)-PI)
		direction = direction.rotated(new_angle_dir*rotation_speed*delta)
