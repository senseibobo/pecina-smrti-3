extends Node2D

export(int, FLAGS, "Easy", "Hard") var difficulty = 3

func _ready():
	if difficulty & int(State.state["difficulty"]+1) == 0:
		queue_free()
		
func _on_Area2D_body_entered(body):
	body.flip_gravity()
	for child in get_parent().get_children():
		if child.name.find("Box") != -1 and child.name.find("Button") == -1:
			child.gravity = -child.gravity
	queue_free()
