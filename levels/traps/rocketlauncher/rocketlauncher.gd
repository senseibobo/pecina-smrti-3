extends Trap

export var shoot_rate : float = 1.0
export var start_shot : float = 0.5
export var rocket_speed : float = 300
export var rocket_rotation_speed : float = 1.6

var shooting : bool = false

func _ready():
	$Timer.wait_time = shoot_rate

func _process(_delta):
	if (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")) and not shooting:
		shooting = true
		yield(get_tree().create_timer(start_shot,false),"timeout")
		_on_Timer_timeout()
		$Timer.start()

func _on_Timer_timeout():
	$Timer.wait_time = shoot_rate
	var rocket = preload("res://levels/traps/rocketlauncher/rocket/rocket.tscn").instance()
	rocket.global_position = $shootpos.global_position
	rocket.target = Game.get_player()
	rocket.speed = rocket_speed
	rocket.rotation_speed = rocket_rotation_speed
	rocket.launch_at_angle(global_rotation)
	Game.get_world().add_child(rocket)
