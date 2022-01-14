extends KinematicBody2D

var target : Node
var rotation_speed : float = 160
var speed : float = 300

onready var particles = $Particles2D

func destroy():
	queue_free()
	particles.get_parent().remove_child(particles)
	Game.add_child(particles)
	particles.queue_death()

func _physics_process(delta):
	if target != null:
		var tpos = Game.get_player_position()
		rotation += sign(get_angle_to(tpos))*rotation_speed*delta/100
	var collision = move_and_collide(speed*Vector2.RIGHT.rotated(rotation)*delta)
	if collision:
		explode(collision.collider)

func explode(body):
	destroy()
	explosion_particles()
	if body.has_method("death"):
		body.death()
	particles.get_parent().remove_child(particles)
	if particles.get_parent() == null:
		Game.add_child(particles)
	particles.global_position = global_position
	particles.queue_death()
	particles.emitting = false
	particles.rotation = rotation
	Game.shake_screen(10,1)
	Game.get_audio().explosion_sound()
	
func explosion_particles():
	var explosion = $Explosion
	remove_child(explosion)
	Game.add_child(explosion)
	explosion.queue_death()
	explosion.emitting = true
	explosion.global_position = global_position
