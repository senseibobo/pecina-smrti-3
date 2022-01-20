extends Boss


var idle_duration = 1

onready var bhm = $BulletHellManager
onready var sprite = $Darko/Sprite
onready var darko = $Darko

func _init():
	boss_name = "Darko"
	boss_id = "darko"
	phase = 1

		
		
func launch_bloodball(pos : Vector2, rot = null,target = Game.get_player()):
	var bloodball = preload("res://bosses/darko/attacks/first/bloodball.tscn").instance()
	bloodball.global_position = pos
	Game.get_world().add_child(bloodball)
	if target != null:
		bloodball.target = target
		if rot == null:	bloodball.launch_towards(target.global_position)
		else:			bloodball.launch_at_angle(rot)
	else:
		if rot == null:	bloodball.direction = Vector2.DOWN
		else:			bloodball.direction = Vector2.RIGHT.rotated(rot)
	Game.shake_screen(10,0.2)
	return bloodball
	
	

		
		
func create_lasergun(pos,rot,prep,time,scale = Vector2(1,1)):
	var lasergun = preload("res://bosses/darko/attacks/second/lasergun.tscn").instance()
	lasergun.global_position = pos
	lasergun.rotation = deg2rad(rot)
	lasergun.prep = prep
	lasergun.time = time
	lasergun.scale = scale
	Game.get_world().add_child(lasergun)
	

func next_phase_condition():
	return Game.fires_collected >= 14
	
	

	
	

	
				
func steal_fire():
	var fire = preload("res://other/ancientfire.tscn").instance()
	fire.get_node("Area2D").monitoring = false
	fire.global_position = Game.get_player().global_position
	fire.get_node("AncientFireParticles").preprocess = 0
	Game.get_world().add_child(fire)
	fire.fly_to(darko.global_position)
