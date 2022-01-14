extends Node2D

export var rotation_speed : float = 100

func _process(delta):
	rotation += delta*rotation_speed/30
	rotation = fmod(rotation,TAU)


func _on_Area2D_body_entered(body):
	if SceneManager.transitioning: return
	body.death()
	rotation_speed = 0
