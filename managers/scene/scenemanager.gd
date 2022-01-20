extends Node

signal transition_started
signal transition_complete

var current_scene : Node setget set_current_scene


var transition_time = 0.8
var transitioning : bool = false




func set_current_scene(scene):
	Audio.reset()
	if scene is String:
		scene = load(scene)
	var new_scene = scene as Object
	get_tree().call_deferred("change_scene_to",new_scene)
	Game.emit_signal("scene_changed")
	
func transition_to(scene,time : float = transition_time):
	var transition = preload("res://managers/transition/transition.tscn").instance()
	transition.transition_to = scene
	transition.transition_time = time
	transitioning = true
	get_tree().root.add_child(transition)
	emit_signal("transition_started")
	transition.connect("transitioned",self,"set_current_scene",[scene])
	transition.connect("transition_complete",transition,"queue_free")
	return transition

func _transition_complete():
	emit_signal("transition_complete")
	transitioning = false
