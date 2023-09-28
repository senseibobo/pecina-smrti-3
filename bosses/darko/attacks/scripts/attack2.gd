extends Attack

func _init():
	easy = {
		"pre_delay" : 0.2,
		"post_delay" : 0.3,
		"wave_time": 0.3,
		"prep_time": 0.8,
		"laser_time": 0.1,
		"wave_count": 3,
		"laser_count" : 4, 
	}
	hard = {
		"pre_delay" : 0.2,
		"post_delay" : 0.3,
		"wave_time": 0.2,
		"prep_time": 0.7,
		"laser_time": 0.3,
		"wave_count": 4,
		"laser_count" : 3, 
	}
	vars = [easy,hard][State.state["difficulty"]]

func attack(boss): #create waves of laser guns pointing straight down
	yield(boss.relocate_to(Vector2(576,120),0.5),"tween_all_completed")
	var w = 1152.0/vars["laser_count"]
	for i in range(vars["wave_count"]):
		for j in range(vars["laser_count"]):
			boss.create_lasergun(Vector2(j*w + rand_range(0,w) ,100),90,vars["prep_time"],vars["laser_time"])
		yield(Tools.timer(vars["wave_time"]),"timeout")
	boss.emit_signal("attack_finished")
