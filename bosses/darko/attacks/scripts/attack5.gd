extends Attack

func _init():
	easy = {
		"pre_delay" : 0.0,
		"post_delay" : 0.0,
		"laser_count" : 9,
		"initial_laser_delay" : 0.7,
		"laser_delay" : 0.15,
		"additional_shots" : 6,
	}
	hard = {
		"pre_delay" : 0.0,
		"post_delay" : 0.0,
		"laser_count" : 9,
		"initial_laser_delay" : 0.7,
		"laser_delay" : 0.15,
		"additional_shots" : 6,
	}
	vars = [easy,hard][State.state["difficulty"]]


func attack(boss): #| | | | | | | laser
	yield(boss.relocate_to(Vector2(576,50),0.3),"tween_all_completed")
	
	var current_place = 0
	var offset = randi()%64
	var dir = randi()%2*2-1
	
	for j in range(vars["laser_count"]):
		boss.create_lasergun(Vector2(offset+j*160+current_place,48),90,1.0,0.12)
		
	yield(Tools.timer(vars["initial_laser_delay"],boss), "timeout")
	for i in range(vars["additional_shots"]):
		current_place += dir*32
		yield(Tools.timer(vars["laser_delay"],boss), "timeout")
		for j in range(vars["laser_count"]):
			boss.create_lasergun(Vector2(offset+j*160+current_place,48),90,0.4,0.12)
	boss.emit_signal("attack_finished")
