extends Attack

func _init():
	easy = {
		"pre_delay" : 0.6,
		"post_delay" : 0.3,
		"count" : 10,
		"prepare_time" : 0.45,
		"laser_time" : 0.05,
		"laser_spacing" : 220.0,
		"delay1" : 0.1,
		"delay2" : 0.03,
	}
	hard = {
		"pre_delay" : 0.6,
		"post_delay" : 0.3,
		"count" : 10,
		"prepare_time" : 0.45,
		"laser_time" : 0.05,
		"laser_spacing" : 220.0,
		"delay1" : 0.1,
		"delay2" : 0.03,
	}
	vars = [easy,hard][State.state["difficulty"]]
	
func attack(boss): # laser and bloodball spam attack
	yield(boss.relocate_to(Vector2(576,200)),"tween_all_completed")
	for i in range(vars["count"]):
		for j in range(3):
			boss.create_lasergun(
				Vector2(Game.get_player().global_position.x + (j-1)*vars["laser_spacing"],50),
				90,
				vars["prepare_time"],
				vars["laser_time"]
			)
		yield(Tools.timer(vars["delay1"],boss),"timeout")
		boss.launch_bloodball(boss.boss_node.global_position)
		yield(Tools.timer(vars["delay2"],boss),"timeout")
	boss.emit_signal("attack_finished")
