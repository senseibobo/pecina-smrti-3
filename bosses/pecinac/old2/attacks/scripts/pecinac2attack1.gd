extends Attack

const wave_scene = preload("res://bosses/pecinac/2/attacks/1/wave.tscn")

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

func attack(boss : Boss):
	boss.cast_spell(Color.aquamarine)
	var disappearing = randi()%3
	for i in range(3):
		print(i)
		var wave = wave_scene.instance()
		wave.global_position = Vector2(192+i*384,-400)
		boss.add_child(wave)
		move_wave(wave)
		if disappearing != i:
			disappear(wave)
	yield(Tools.timer(1.0,boss),"timeout")
	boss.stop_casting()
	boss.emit_signal("attack_finished")
	
		
func disappear(wave):
	wave.get_node("CollisionShape2D").set_deferred("disabled",true)
	yield(Tools.timer(0.5,wave),"timeout")
	yield(Tools.tween(
		wave,
		"modulate",
		wave.modulate*Color(1,1,1,1),
		wave.modulate*Color(1,1,1,0),
		1.0,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT
	),"tween_all_completed")

func move_wave(wave):
	yield(Tools.tween(
		wave,
		"global_position",
		wave.global_position,
		wave.global_position + Vector2.DOWN*1500,
		2.0,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT_IN,
		true
	),"tween_all_completed")
	





