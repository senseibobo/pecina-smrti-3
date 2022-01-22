extends StaticBody2D

signal done

func launch_toward(pos : Vector2):
	rotation = pos.angle_to_point(global_position)
	yield(
		Tools.tween(
			self,
			"global_position",
			global_position,
			pos,
			1.5,
			Tween.TRANS_QUART,
			Tween.EASE_IN
		),
		"tween_all_completed"
	)
	Game.shake_screen(10,0.5)
	yield(Tools.timer(0.2,self),"timeout")
	remove_from_group("Death")
	$Sprite.texture = preload("res://bosses/pecinac/1/attacks/3/siljak2.png")
	emit_signal("done")
