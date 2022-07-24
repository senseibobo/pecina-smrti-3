extends StaticBody2D


export(int, FLAGS, "Easy", "Hard") var difficulty = 3

func _ready():
	if difficulty & int(State.state["difficulty"]+1) == 0:
		queue_free()
