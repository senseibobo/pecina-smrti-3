extends Attack

const plamen_scene = preload("res://bosses/pecinac/2/attacks/2/bacacplamena.tscn")

func _init():
	easy = {
		"pre_delay" : 0.6,
		"post_delay" : 0.0,
	}
	hard = {
		"pre_delay" : 0.6,
		"post_delay" : 0.0,
	}
	vars = [easy,hard][Game.difficulty]

func attack(boss : Boss):
	boss.cast_spell(Color.aquamarine)
	var plamen
	var dir = (randi()%2*2)-1
	for i in 6:
		plamen = plamen_scene.instance()
		plamen.global_position = Vector2(576+736*dir,i*648/6)
		plamen.rotation = PI/2+dir*PI/2
		boss.add_child(plamen)
		yield(Tools.timer(0.12,boss),"timeout")
	yield(plamen,"stopped")
	boss.stop_casting()
	yield(plamen,"done")
	boss.emit_signal("attack_finished")




