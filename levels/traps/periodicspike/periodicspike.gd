extends Trap

export var spike_period : float = 0.5

onready var spike = $Spike as Node2D
onready var tween = $Tween
onready var start_position = global_position
onready var dest = start_position+Vector2(0.5,14)

func _ready():
	$Timer.wait_time = spike_period

func hit():
	tween.interpolate_property(self,"global_position",start_position,dest,0.05)
	tween.start()
	yield(tween,"tween_completed")
	tween.interpolate_property(self,"global_position",dest,start_position,0.15)
	tween.start()
