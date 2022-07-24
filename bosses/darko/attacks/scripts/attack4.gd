extends Attack

func _init():
	easy = {
		"pre_delay" : 0.3,
		"post_delay" : 0.0,
		"ball_count" : 15,
		"attack_time" : 1.0,
	}
	hard = {
		"pre_delay" : 0.3,
		"post_delay" : 0.0,
		"ball_count" : 15,
		"attack_time" : 1.0,
	}
	vars = [easy,hard][State.state["difficulty"]]

func attack(boss): #go from one side to almost the other and shower the floor with balls
	var dir = randi()%2*2-1
	yield(boss.relocate_to(Vector2(576+dir*500,96),0.6),"tween_all_completed")
	boss.relocate_to(Vector2(576-dir*400,96),vars["attack_time"])
	for i in range(vars["ball_count"]):
		boss.launch_bloodball(boss.boss_node.global_position,deg2rad(90))
		yield(Tools.timer(vars["attack_time"]/vars["ball_count"],boss), "timeout")
	boss.emit_signal("attack_finished")
