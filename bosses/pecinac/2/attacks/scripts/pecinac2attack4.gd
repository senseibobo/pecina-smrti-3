extends Attack

const laser_scene = preload("res://bosses/pecinac/2/attacks/lasereyes/laser.tscn")

func _init():
	easy = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
	}
	hard = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
	}
	vars = [easy,hard][State.state["difficulty"]]

func attack(boss):
	pass
	

