extends CanvasLayer

signal transition_complete
signal transitioned


var transition_to = null
onready var transition_time : float

onready var tween = $Tween
onready var colorrect = $ColorRect

func _ready():
	tween.interpolate_property(colorrect.get_material(),"shader_param/progress",0,1,transition_time,Tween.TRANS_QUINT,Tween.EASE_IN_OUT)
	tween.start()
	yield(tween,"tween_completed")
	emit_signal("transitioned")
	Game.update_deaths()
	Game.update_level()
	tween.interpolate_property(colorrect.get_material(),"shader_param/progress",1,2.1,transition_time,Tween.TRANS_QUINT,Tween.EASE_IN_OUT)
	tween.start()
	SceneManager.set_current_scene(transition_to)
	yield(tween,"tween_completed")
	emit_signal("transition_complete")
	SceneManager.transitioning = false
	queue_free()
