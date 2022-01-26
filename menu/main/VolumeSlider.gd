extends HSlider

class_name VolumeSlider

const l := 100.0
const m := 1.7

func _ready():
	value = 0 if Audio.volume_db == -500 else Audio.volume_db*m + l
	connect("value_changed",self,"volume_changed")

func volume_changed(value):
	print(value)
	if value == 0:
		Audio.volume_db = -500
	else:
		Audio.volume_db = (value - l)/m
