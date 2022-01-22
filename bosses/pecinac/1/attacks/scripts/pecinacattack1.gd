extends Attack

var meteor_scene = preload("res://bosses/pecinac/1/attacks/1/meteor.tscn")

func _init():
	easy = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
	}
	hard = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
	}
	vars = [easy,hard][Game.difficulty]

func attack(boss):
	boss.cast_spell(Color.aqua)
	var meteor = meteor_scene.instance()
	meteor.global_position = boss.boss_node.global_position + Vector2.RIGHT.rotated(rand_range(0,TAU))*100
	boss.add_child(meteor)
	yield(meteor,"assembled")
	var player = Game.get_player()
	var dest = player.global_position + player.velocity*0.5
	meteor.direction = meteor.global_position.direction_to(dest)
	boss.stop_casting()
	boss.emit_signal("attack_finished")

	
