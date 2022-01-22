extends Attack

const siljak_scene = preload("res://bosses/pecinac/1/attacks/3/siljak.tscn")
const uzvicnik_scene = preload("res://bosses/pecinac/1/attacks/3/uzvicnik.tscn")

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
	boss.cast_spell(Color.purple)
	var siljak = siljak_scene.instance()
	var angle = rand_range(0,TAU)
	var pos = Vector2(576,380) + Vector2.RIGHT.rotated(angle)*576
	siljak.rotation = angle + PI
	siljak.global_position = pos
	boss.add_child(siljak)
	var uzvicnik = uzvicnik_scene.instance()
	var dest = Vector2(576+rand_range(-100,100),380+rand_range(-100,100))
	uzvicnik.global_position = dest.linear_interpolate(pos,0.5)
	boss.add_child(uzvicnik)
	uzvicnik.global_position.x = clamp(uzvicnik.global_position.x,100,1052)
	uzvicnik.global_position.y = clamp(uzvicnik.global_position.y,100,548)
	siljak.launch_toward(dest)
	yield(siljak,"done")
	boss.stop_casting()
	boss.emit_signal("attack_finished")
