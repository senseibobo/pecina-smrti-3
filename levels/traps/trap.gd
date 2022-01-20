extends Area2D
class_name Trap

export(int, FLAGS, "Easy", "Hard") var difficulty = 3

func _ready():
	connect("body_entered",self,"body_entered")
	collision_layer = 4
	collision_mask = 2
	if difficulty & (Game.difficulty+1) == 0:
		queue_free()

func body_entered(body):
	body.death()
