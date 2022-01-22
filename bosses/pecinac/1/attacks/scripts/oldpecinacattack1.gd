extends Attack

const crumbling_floor_scene = preload("res://bosses/pecinac/1/attacks/1/crumblingfloor.tscn")
const spikes_scene = preload("res://levels/traps/spikes/spikes.tscn")

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
	print("AAA")
	boss.relocate_to(Vector2(576,300))
	boss.cast_spell(Color.aqua)
	for j in range(6):
		var fn1 = Node2D.new()
		var fn2 = Node2D.new()
		fn1.global_position = Vector2(0,680)
		fn2.global_position = Vector2(0,680)
		boss.add_child(fn1)
		boss.add_child(fn2)
		var i
		i = -16
		while i < 1152:
			i+=32
			if rand_range(0,100) > 40: 
				var f = crumbling_floor_scene.instance()
				fn1.add_child(f)
				f.global_position = Vector2(i,680)
		i = -16
		var tween = Tools.tween(fn1,"global_position",Vector2(0,680),Vector2(0,-32),3.0,Tween.TRANS_CUBIC,Tween.EASE_IN)
		tween.connect("tween_all_completed",fn1,"queue_free")
		Game.shake_screen(10,1)
		yield(Tools.timer(0.45,boss),"timeout")
		while i < 1152:
			i+=52
			if rand_range(0,100) > 70:
				var s = spikes_scene.instance()
				fn2.add_child(s)
				s.global_position = Vector2(i,680)
		Game.shake_screen(5,1)
		tween = Tools.tween(fn2,"global_position",Vector2(0,680),Vector2(0,-32),3.0,Tween.TRANS_CUBIC,Tween.EASE_IN)
		tween.connect("tween_all_completed",fn2,"queue_free")
		yield(Tools.timer(0.45,boss),"timeout")
	boss.stop_casting()
	boss.emit_signal("attack_finished")
