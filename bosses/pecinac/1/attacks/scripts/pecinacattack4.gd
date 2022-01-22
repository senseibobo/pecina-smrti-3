extends Attack

const koplje_scene = preload("res://bosses/pecinac/1/attacks/4/koplje.tscn")

func _init():
	easy = {
		"pre_delay" : 0.0,
		"post_delay" : 1.0,
	}
	hard = {
		"pre_delay" : 0.0,
		"post_delay" : 1.0,
	}
	vars = [easy,hard][Game.difficulty]

func attack(boss):
	boss.cast_spell(Color.white)
	yield(Tools.timer(0.4,boss),"timeout")
	for i in range(5):
		var koplje = koplje_scene.instance()
		var pos = boss.boss_node.global_position + Vector2(rand_range(-100,100),rand_range(-100,100))
		koplje.direction = pos.direction_to(Game.get_player().global_position)
		koplje.global_position = pos
		koplje.rotation = koplje.direction.angle()
		boss.add_child(koplje)
		yield(Tools.timer(0.2,boss),"timeout")
	boss.stop_casting()
	boss.emit_signal("attack_finished")
