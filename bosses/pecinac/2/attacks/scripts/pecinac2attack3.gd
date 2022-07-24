extends Attack

const laser_scene = preload("res://bosses/pecinac/2/attacks/lasereyes/laser.tscn")

func _init():
	easy = {
		"pre_delay" : 0.5,
		"post_delay" : 0.0,
	}
	hard = {
		"pre_delay" : 0.4,
		"post_delay" : 0.0,
	}
	vars = [easy,hard][State.state["difficulty"]]

func attack(boss): # laser dole
	boss.create_lasergun(Vector2(-200,520),0,0.85,0.1,Vector2(1,2.5))
	yield(Tools.timer(0.4),"timeout")
	boss.emit_signal("attack_finished")

