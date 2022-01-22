extends Node

func _unhandled_input(event):
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

func tween(object,property,from,to,duration,tw1 = Tween.TRANS_LINEAR,tw2 = Tween.EASE_IN_OUT) -> Tween:
	var tween = Tween.new()
	get_tree().current_scene.add_child(tween)
	tween.connect("tween_all_completed",tween,"queue_free")
	tween.interpolate_property(object,property,from,to,duration,tw1,tw2)
	tween.start()
	return tween

func timer(time,object = get_tree().current_scene) -> Timer:
	var timer = Timer.new()
	object.add_child(timer)
	timer.start(time)
	timer.connect("timeout",timer,"queue_free")
	return timer
