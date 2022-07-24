extends Attack

const rocket_scene : PackedScene = preload("res://levels/traps/rocketlauncher/rocket/rocket.tscn")

func _init():
	easy = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
	}
	hard = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
	}
	vars = [easy,hard][State.state["difficulty"]]

func attack(boss : Boss):
	boss.cast_spell(Color.aquamarine)
	var player = Game.get_player()
	for i in 10:
		var rocket = rocket_scene.instance()
		rocket.global_position = boss.boss_node.get_node("SpellHand").rect_global_position
		boss.add_child(rocket)
		rocket.launch_at_angle(i*TAU/10.0)
		rocket.speed = 400.0
		rocket.rotation_speed = 1.0
		rocket.target = player
		yield(Tools.timer(0.1,boss),"timeout")
	boss.stop_casting()
	boss.emit_signal("attack_finished")




