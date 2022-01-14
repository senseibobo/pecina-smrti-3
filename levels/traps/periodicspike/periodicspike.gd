extends Node2D

export var spike_period : float = 0.5

onready var spike = $Spike as Node2D
onready var tween = $Tween

func _ready():
	$Timer.wait_time = spike_period

func hit():
	tween.interpolate_property(spike,"position",Vector2(0.5,0),Vector2(0.5,-14),0.05)
	tween.start()
	yield(tween,"tween_completed")
	tween.interpolate_property(spike,"position",Vector2(0.5,-14),Vector2(0.5,0),0.15)
	tween.start()
