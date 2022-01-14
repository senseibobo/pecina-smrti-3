extends Control



func _ready():
	if not OS.get_name() in ["Android","iOS"]:
		queue_free()
