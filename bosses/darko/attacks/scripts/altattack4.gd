extends Attack

func _init():
	easy = {
		"pre_delay" : 0.2,
		"post_delay" : 1.4
	}
	hard = {
		"pre_delay" : 0.2,
		"post_delay" : 1.4
	}
	vars = [easy,hard][State.state["difficulty"]]

func attack(boss): # meteor throw
	yield(boss.relocate_to(Vector2(576,50)),"tween_all_completed")
	for i in range(5):
		var rock = preload("res://bosses/darko/attacks/ancientrock/ancientrock.tscn").instance()
		rock.global_position = boss.boss_node.global_position + Vector2(rand_range(-300,300),0)
		Game.get_world().add_child(rock)
		if rand_range(0,100) > 66:
			rock.launch_towards(Game.get_player().global_position)
			rock.direction = rock.direction.rotated(rand_range(-0.2,0.2))
		else:
			rock.launch_towards(Vector2([0,1152][randi()%2],rand_range(300,600)))
		yield(Tools.timer(0.5,boss),"timeout")
	boss.emit_signal("attack_finished")
