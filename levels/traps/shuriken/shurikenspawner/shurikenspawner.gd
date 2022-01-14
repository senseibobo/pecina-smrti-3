extends ColorRect

export var shoot_rate : float = 0.2
export var start_shot : float = 0.1
export var shuriken_direction_degrees : float = -90
export var shuriken_speed : float = 700
export var shuriken_scale : float = 1
export var step : int = 1
export var shuriken_count : int = 1
export var disappearing : bool = true #OPREZNO
export var random : bool = true

func _ready():
	color.a = 0
	$Timer.start(start_shot); yield($Timer,"timeout")
	_on_Timer_timeout()
	$Timer.stop()
	$Timer.start(shoot_rate)
	




func _on_Timer_timeout():
	var current_place : int = 0
	for i in shuriken_count:
		var shuriken = preload("res://levels/traps/shuriken/shuriken.tscn").instance()
		var world = Game.get_world()
		if world != null: world.add_child(shuriken)
		else: add_child(shuriken)
		shuriken.direction = Vector2.RIGHT.rotated(-deg2rad(shuriken_direction_degrees))
		if random:
			shuriken.global_position.x = rect_global_position.x + int(int(rand_range(0,rect_size.x))/step)*step
			shuriken.global_position.y = rect_global_position.y + int(int(rand_range(0,rect_size.y))/step)*step
		else:
			shuriken.global_position.x = rect_global_position.x + current_place % int(rect_size.x)
			shuriken.global_position.y = rect_global_position.y
			current_place += step
		shuriken.disappearing = true
		shuriken.speed = shuriken_speed
		shuriken.scale = Vector2(1,1)*shuriken_scale
		shuriken.disappearing = disappearing
	
