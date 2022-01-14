extends Node2D

var flying : bool = false
var destination : Vector2
var direction : Vector2
var speed = 1000

func _on_Area2D_body_entered(body):
	body.fires_collected += 1
	queue_free()

func _process(delta):
	global_rotation = 0
	if flying:
		#direction = direction.rotated(global_position.angle_to(destination)*delta*10.0)
		direction = lerp(direction,global_position.direction_to(destination),20*delta)
		global_position += speed*direction.normalized()*delta
		if global_position.distance_to(destination) < 20:
			queue_free()
		

func fly_to(pos : Vector2):
	destination = pos
	direction = global_position.direction_to(pos).rotated(rand_range(-0.5,0.5))
	flying = true
