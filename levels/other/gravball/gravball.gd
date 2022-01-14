extends Node2D

func _on_Area2D_body_entered(body):
	body.flip_gravity()
	for child in get_parent().get_children():
		if child.name.find("Box") != -1 and child.name.find("Button") == -1:
			child.gravity = -child.gravity
	queue_free()
