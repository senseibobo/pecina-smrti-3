extends Attack

func _init():
	easy = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
	}
	hard = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
	}
	vars = [easy,hard][Game.difficulty]

func attack(boss):
	pass
	
