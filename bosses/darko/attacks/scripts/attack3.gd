extends Attack

func _init():
	easy = {
		"pre_delay" : 0.0,
		"post_delay" : 0.7,
		"iterations" : 5,
		"balls" : 5,
		"acceleration" : 600.0,
		"initial_velocity" : 0.0,
		"delay" : 0.3,
	}
	hard = {
		"pre_delay" : 0.0,
		"post_delay" : 0.7,
		"iterations" : 3,
		"balls" : 5,
		"acceleration" : 800.0,
		"initial_velocity" : 200.0,
		"delay" : 0.15
	}
	vars = [easy,hard][State.state["difficulty"]]

func attack(boss): #side to side 5 balls
	var dir = randi()%2
	for i in range(vars["iterations"]):
		dir = (dir+1)%2
		yield(boss.relocate_to(Vector2(20+dir*1132,120),0.2),"tween_all_completed")
		var missing = randi()%3/2+(vars["balls"]-2)
		for j in range(vars["balls"]):
			if j == missing: continue
			var pos = Vector2(30+dir*1092,160+j*80)
			var rot = 0.0 if dir == 0 else PI
			var bloodball = boss.launch_bloodball(pos,rot,null,true)
			bloodball.speed = vars["initial_velocity"]
			bloodball.acceleration = vars["acceleration"]
		yield(Tools.timer(vars["delay"],boss), "timeout")
	boss.emit_signal("attack_finished")
