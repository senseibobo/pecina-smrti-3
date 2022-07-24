extends Attack

const koplje_scene = preload("res://bosses/pecinac/1/attacks/4/koplje.tscn")

func _init():
	easy = {
		"pre_delay" : 0.3,
		"post_delay" : 1.2,
		"count": 4,
		"firerate": 0.7
	}
	hard = {
		"pre_delay" : 0.0,
		"post_delay" : 0.8,
		"count": 6,
		"firerate": 0.1
	}
	vars = [easy,hard][State.state["difficulty"]]

func attack(boss): # spears
	boss.cast_spell(Color.white)
	yield(Tools.timer(0.4,boss),"timeout")
	for i in range(vars["count"]):
		var koplje = koplje_scene.instance()
		var pos = boss.boss_node.global_position + Vector2(rand_range(-100,100),rand_range(-100,100)) + Vector2.UP*100.0
		koplje.direction = pos.direction_to(Game.get_player().global_position)
		koplje.global_position = pos
		koplje.rotation = koplje.direction.angle()
		boss.add_child(koplje)
		yield(Tools.timer(vars["firerate"],boss),"timeout")
	boss.stop_casting()
	boss.emit_signal("attack_finished")
