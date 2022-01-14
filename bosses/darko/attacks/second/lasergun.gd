extends Node2D

var prep
var time

func _ready():
	var laser = preload("res://bosses/darko/attacks/second/laser.tscn").instance()
	laser.position = $shootpos.position
	laser.prep = prep
	laser.time = time
	add_child(laser)
	$Particles2D.emitting = true

func done():
	queue_free()
