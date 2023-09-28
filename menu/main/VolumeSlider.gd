extends HSlider

class_name VolumeSlider

const l := 100.0
const m := 1.7

func _ready():
	value = db2linear(Audio.volume_db)
	connect("value_changed",self,"volume_changed")

func volume_changed(value):
	Audio.volume_db = linear2db(value)
