extends Node2D

export var mirror_x : bool = true
export var mirror_y : bool = true

export var x_multiplier : float = 1.0
export var y_multiplier : float = 1.0

var player : KinematicBody2D = null

var speed : float = 100.0

onready var start_pos = global_position

func _ready():
	player = Game.get_player()
	update_position(1)
	
func _physics_process(delta):
	update_position(delta)
	
func update_position(delta):
	var new_pos : Vector2
	if player != null:
		if mirror_x: new_pos.x = start_pos.x+x_multiplier*(start_pos.x - player.global_position.x)
		else: new_pos.x = player.global_position.x
		
		if mirror_y: new_pos.y = start_pos.y+y_multiplier*(start_pos.y - player.global_position.y)
		else: new_pos.y = player.global_position.y
		
		global_position = new_pos#global_position.linear_interpolate(new_pos,delta*speed)


func _on_Area2D_body_entered(body):
	body.death()
