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
export var hit_sound : AudioStream

export var speed : float
export var direction : Vector2
export var lifetime : float = 10.0
export var non_destructible_time : float = 0.2
export var moving : bool = true

export var player_only : bool = false

onready var full_lifetime = lifetime

func _ready():
	if constant_particles_scene != null: create_constant_particles()
	connect("body_entered",self,"body_entered")
	collision_mask = 3
	collision_layer = 0

func body_entered(body):
	if body is Player:
		hit(body)
		emit_signal("hit_player",body)
	elif not player_only:
		if lifetime + non_destructible_time < full_lifetime:
			hit()
			emit_signal("hit_ground")

func hit(target : Player = null):
	if target != null: target.death()
	if hit_sound != null: Audio.play_sound(hit_sound)
	destroy()
	emit_signal("hit")

func launch_towards(pos : Vector2) -> void:
	direction = global_position.direction_to(pos)
	rotation = direction.angle()

func launch_at_angle(angle : float) -> void:
	direction = Vector2.RIGHT.rotated(angle)
	rotation = angle

func destroy():
	if hit_particles_scene != null: create_hit_particles()
	if constant_particles != null: remove_constant_particles()
	queue_free()

func _process(delta):
	lifetime -= delta
	if lifetime <= 0: destroy()
	if moving:
		global_position += direction.normalized()*speed*delta
	
func create_constant_particles():
	constant_particles = constant_particles_scene.instance()
	constant_particles.rotation = constant_particles_rotation
	constant_particles.local_coords = false
	add_child(constant_particles)

func remove_constant_particles():
	if constant_particles.get_parent() != Game:
		remove_child(constant_particles)
		Game.add_child(constant_particles)
		constant_particles.global_position = global_position
		constant_particles.emitting = false
		constant_particles.queue_death()


func create_hit_particles():
	var hit_particles = hit_particles_scene.instance()
	Game.add_child(hit_particles)
	hit_particles.emitting = true
	hit_particles.global_position = global_position
	hit_particles.queue_death()
	Game.shake_screen(hit_screenshake,1)
