extends Node2D

var gravity : float = 400
var velocity : Vector2

func _process(delta):
	velocity.y += gravity*delta
	global_position += velocity*delta


func _on_Area2D_body_entered(body):
	body.death()
