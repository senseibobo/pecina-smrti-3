extends Area2D
class_name Projectile

signal hit
signal hit_player(player)
signal hit_ground

export var constant_particles_scene : PackedScene
export var constant_particles_rotation : float = -PI/2
var constant_particles : Particles2D

export var hit_particles_scene : PackedScene 
export var hit_screenshake : float = 10

export var speed : float
export var direction : Vector2

func _ready():
	if constant_particles_scene != null: create_constant_particles()
	connect("body_entered",self,"body_entered")
	collision_mask = 3
	collision_layer = 0

func body_entered(body):
	if body is Player:
		hit(body)
		emit_signal("hit_player",body)
	else:
		hit()
		emit_signal("hit_ground")

func hit(target : Player = null):
	if target != null: target.death()
	if hit_particles_scene != null: create_hit_particles()
	queue_free()
	emit_signal("hit")
	remove_constant_particles()

func launch_towards(pos : Vector2) -> void:
	direction = global_position.direction_to(pos)
	rotation = direction.angle()

func launch_at_angle(angle : float) -> void:
	direction = Vector2.RIGHT.rotated(angle)
	rotation = angle

func _process(delta):
	global_position += direction.normalized()*speed*delta
	
func create_constant_particles():
	constant_particles = constant_particles_scene.instance()
	constant_particles.rotation = constant_particles_rotation
	constant_particles.local_coords = false
	add_child(constant_particles)

func remove_constant_particles():
	remove_child(constant_particles)
	Game.add_child(constant_particles)
	constant_particles.global_position = global_position
	print("A")
	constant_particles.emitting = false
	constant_particles.queue_death()


func create_hit_particles():
	var hit_particles = hit_particles_scene.instance()
	Game.add_child(hit_particles)
	hit_particles.emitting = true
	hit_particles.global_position = global_position
	hit_particles.queue_death()
	Game.shake_screen(hit_screenshake,1)
	# Game.get_audio().explosion_sound()
