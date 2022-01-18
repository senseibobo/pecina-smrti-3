var pre_delay := 0.0
var post_delay := 3.0

func attack(horse):
	yield(Tools.tween(
		horse,
		"global_position",
		Vector2(576,-56),
		Vector2(576,488),
		0.8,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN
	),"tween_all_completed")
	Game.shake_screen(100,1)
	Tools.emit_signal("attack_finished")
	
