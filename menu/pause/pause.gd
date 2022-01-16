extends CanvasLayer

onready var control = $Control as Control


func _ready():
	var value = $Control/CenterContainer/VBoxContainer/Audio/HSlider.value
	var volume = value/1.6-60 if value > 0 else -200
	Audio.set_volume_db(volume)

func _physics_process(delta):
	if Input.is_action_just_pressed("pause"):
		control.visible = !control.visible
		get_tree().paused = !get_tree().paused
func _on_HSlider_value_changed(value):
	var volume = value/1.6-60 if value > 0 else -200
	Audio.set_volume_db(volume)


func _on_Button_pressed():
	control.visible = false
	get_tree().paused = false
