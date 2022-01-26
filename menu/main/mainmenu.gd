extends Control


onready var current_menu = $Main
	
func easy():
	Game.difficulty = Game.DIFFICULTY.EASY
	Game.start_game()


func hard():
	Game.difficulty = Game.DIFFICULTY.HARD
	Game.start_game()


func change_menu(new_menu : String) -> void:
	yield(
		Tools.tween(
			current_menu,
			"rect_position",
			Vector2(0,0),
			Vector2(1152,0),
			0.5,
			Tween.TRANS_CUBIC,
			Tween.EASE_IN
		),
		"tween_all_completed"
	)
	
	current_menu.visible = false
	current_menu = get_node(new_menu)
	
	Tools.tween(
		current_menu,
		"rect_position",
		Vector2(-1152,0),
		Vector2(0,0),
		0.5,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT
	)
	current_menu.visible = true
	update()


func quit_game():
	get_tree().quit()


func fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen



