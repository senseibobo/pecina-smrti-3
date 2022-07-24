extends Attack

func _init():
	easy = {
		"pre_delay" : 0.0,
		"post_delay" : 0.0,
		"attack_duration" : 2.5,
		"count" : 50,
		"bullets_per_attack" : 3,
		"rotation_speed" : 0.45,
		"bullet_speed" : 400.0
	}
	hard = {
		"pre_delay" : 0.0,
		"post_delay" : 0.0,
		"attack_duration" : 2.5,
		"count" : 50,
		"bullets_per_attack" : 3,
		"rotation_speed" : 0.45,
		"bullet_speed" : 400.0
	}
	vars = [easy,hard][State.state["difficulty"]]

func attack(boss): # bullet hell 1 fuck
	var current_angle = 0
	var increment : float = [-1,1][randi()%2]
	yield(boss.relocate_to(Vector2(576-increment*500,100)),"tween_all_completed")
	boss.relocate_to(Vector2(576+increment*500,100),vars["attack_duration"])
	for i in vars["count"]:
		current_angle += increment*vars["rotation_speed"]
		for j in range(vars["bullets_per_attack"]):
			boss.bhm.origin.global_position = boss.boss_node.global_position
			var angle = (increment+1)/2*PI+TAU*j/vars["bullets_per_attack"] + current_angle
			boss.bhm.spawn_bullet(NormalBullet.new(),vars["bullet_speed"],Vector2(1,0).rotated(angle),0)
		yield(Tools.timer(vars["attack_duration"]/vars["count"],boss),"timeout")
	boss.emit_signal("attack_finished")
