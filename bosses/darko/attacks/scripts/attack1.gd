extends Attack

func _init():
	easy = {
		"pre_delay" : 0.0,
		"post_delay" : 0.0,
		"prepare_time" : 0.6,
		"attack_time" : 2.7,
		"attack_count" : 4
	}
	hard = {
		"prepare_time" : 0.5,
		"attack_time" : 2.5,
		"attack_count" : 6,
		"pre_delay" : 0.0,
		"post_delay" : 0.0
	}
	vars = [easy,hard][Game.difficulty]
	

func attack(boss): #go from one side to the other and launch 5 homing balls at the player
	var dir = randi()%2*2-1
	yield(boss.relocate_to(Vector2(576+432*dir,162),vars["prepare_time"]),"tween_all_completed")
	boss.relocate_to(Vector2(576-432*dir,162),vars["attack_time"])
	
	var wait_time = (vars["attack_time"] / vars["attack_count"])
	for i in range(vars["attack_count"]):
		var pos = boss.boss_node.global_position + Vector2.RIGHT.rotated(rand_range(0,TAU))*70
		boss.launch_bloodball(pos)
		yield(Tools.timer(wait_time,boss),"timeout")
	
	boss.emit_signal("attack_finished")
