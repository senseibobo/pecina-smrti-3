extends Attack

func _init():
	pre_delay = 0.0
	post_delay = 0.3
	easy = {
		"pre_delay" : 0.0,
		"post_delay" : 0.3,
		"count" : 12
	}
	hard = {
		"pre_delay" : 0.0,
		"post_delay" : 0.3,
		"count" : 16
	}
	vars = [easy,hard][Game.difficulty]

func attack(boss): #create 15 laserguns that aim with at most 10 degree tilt from down
	yield(boss.relocate_to(Vector2(576,120),0.5),"tween_all_completed")
	for i in range(vars["count"]):
		boss.create_lasergun(Vector2(i*(1152.0/vars["count"]),rand_range(50,150)),rand_range(100,80),0.75,0.3)
	boss.emit_signal("attack_finished")
