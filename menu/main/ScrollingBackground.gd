extends Node2D

onready var bg1 = $Background
onready var bg2 = $Background2

onready var size = bg1.texture.get_size().x*bg1.scale.x
var speed : float = 80
func _process(delta):
	bg1.global_position.x = wrapf(bg1.global_position.x - delta*speed,-size,0)
	bg2.global_position.x = bg1.global_position.x + size
