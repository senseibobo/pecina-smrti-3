extends Node2D

enum states {
	idle,
	attacking,
	dying,
	reviving
}

export var max_health : float = 45
onready var health : float = max_health

onready var state = states.idle
onready var state_duration_left = 2
onready var current_attack = 0
const ATTACK_NUMBER = 5

var attack_duration = [	2.2,2,2.5,1.5,1.2,
						3.0,1.8,2.5,4  ,3]
var idle_duration = 1

onready var bhm = $BulletHellManager
onready var sprite = $Darko/Sprite
onready var name_label = $CanvasLayer/ColorRect2/Label
onready var tween = $Tween
onready var animplayer = $AnimationPlayer
onready var darko = $Darko
onready var timer = $Timer
onready var shaderrect = $CanvasLayer/ShaderRect
onready var healthbar = $CanvasLayer/ColorRect2

func _ready():
	animplayer.play("birth")
	match Game.darko_phase:
		1:
			if Game.get_audio().current_song != "darko":
				Game.get_audio().play_music("darko")
			sprite.texture = preload("res://bosses/darko/darko.png")
		2:
			if Game.get_audio().current_song != "darko2":
				Game.get_audio().play_music("darko2")
			sprite.modulate = Color(2.5,2.5,2.5,1)
			sprite.texture = preload("res://bosses/darko/darko2.png")
			name_label.text = "DARKO - OLICENJE ZLA"
			health = max_health
func choose_attack():
#	current_attack = [4,4][randi()%2]
#	return
	if ATTACK_NUMBER <= 1: 
		current_attack = 0
		return
	var old_attack = current_attack
	while current_attack == old_attack:
		current_attack = randi()%ATTACK_NUMBER
func attack(attack):
	var number = str(["first","second","third","fourth","fifth"][attack])
	var alt = "" if Game.darko_phase == 1 else "alt_"
	call(alt+number+"_attack")
func first_attack(): #go from one side to the other and launch 5 homing balls at the player
	var num = randi()%2
	if num == 1:
		relocate_to(Vector2(1008,162),0.5)
	else:
		relocate_to(Vector2(144,162),0.5)
	yield(tween,"tween_completed")
	if state != states.attacking: return
	if num == 1:
		animplayer.play("first_attack")
	else:
		animplayer.play_backwards("first_attack")
func launch_bloodball(pos = null, rot = null,target = Game.get_player()):
	var bloodball = preload("res://bosses/darko/attacks/first/bloodball.tscn").instance()
	Game.shake_screen(10,0.2)
	if pos != null:
		bloodball.global_position = pos
	else:
		bloodball.global_position = darko.global_position + Vector2.RIGHT.rotated(rand_range(0,TAU))*70
	Game.get_world().add_child(bloodball)
	if target != null:
		bloodball.target = target
		if rot == null:	bloodball.launch_towards(target.global_position)
		else:			bloodball.launch_at_angle(rot)
	else:
		if rot == null:	bloodball.direction = Vector2.DOWN
		else:			bloodball.direction = Vector2.RIGHT.rotated(rot)
func second_attack(): #create 15 laserguns that aim with at most 10 degree tilt from down
	relocate_to(Vector2(576,120),0.5)
	yield(tween,"tween_completed")
	for i in range(15):
		create_lasergun(Vector2(i*(1152/15),rand_range(50,150)),rand_range(100,80),0.75,0.75)
func create_lasergun(pos,rot,prep,time,scale = Vector2(1,1)):
	var lasergun = preload("res://bosses/darko/attacks/second/lasergun.tscn").instance()
	lasergun.global_position = pos
	lasergun.rotation = deg2rad(rot)
	lasergun.prep = prep
	lasergun.time = time
	lasergun.scale = scale
	Game.get_world().add_child(lasergun)
func third_attack(): #go side to side 4 times and launch 5 balls to the other side with 1 ball missing
	var dir = randi()%2
	for _i in range(4):
		if state == states.dying and state == states.reviving: return
		dir = (dir+1)%2
		relocate_to(Vector2(20+dir*1132,120),0.2)
		yield(tween,"tween_completed")
		var missing = randi()%3/2+3
		for j in range(5):
			if j == missing: continue
			var pos = Vector2(20+dir*1112,160+j*80)
			var rot = 0.0 if dir == 0 else PI
			launch_bloodball(pos,rot,null)
		timer.start(0.5); yield(timer, "timeout")
func fourth_attack(): #go from one side to almost the other and shower the floor with balls
	var dir = randi()%2
	relocate_to(Vector2(50+dir*1052,96),0.6)
	yield(tween,"tween_completed")
	dir = -1 if dir == 0 else 1
	var time : float = 1
	var ball_count : float= 15
	relocate_to(Vector2(576-dir*400,96),time)
	for _i in range(ball_count):
		if state == states.dying and state == states.reviving: return
		launch_bloodball(darko.global_position,deg2rad(90))
		timer.start(time/ball_count); yield(timer, "timeout")
func fifth_attack(): #| | | | | | | laser
	relocate_to(Vector2(576,50),0.3)
	var current_place = 0
	var offset = randi()%64
	var dir = (randi()%2)*2-1
	timer.start(0.3); yield(timer, "timeout")
	for j in range(9):
		create_lasergun(Vector2(offset+j*160+current_place,48),90,1.0,0.12)
	timer.start(0.7); yield(timer, "timeout")
	for _i in range(6):
		if state == states.dying and state == states.reviving: return
		current_place += dir*32
		timer.start(0.15); yield(timer, "timeout")
		for j in range(9):
			create_lasergun(Vector2(offset+j*160+current_place,48),90,0.4,0.12)
func alt_first_attack():
	var current_angle = 0
	var increment : float = [-1,1][randi()%2]
	relocate_to(Vector2(576-increment*500,100))
	yield(tween,"tween_completed")
	relocate_to(Vector2(576+increment*500,100),2.5)
	for i in 50:
		if state == states.dying: return
		current_angle += increment*0.45
		for j in range(3):
			bhm.origin.global_position = darko.global_position
			var angle = (increment+1)/2*PI+TAU*j/3 + current_angle
			bhm.spawn_bullet(400,Vector2(1,0).rotated(angle),0)
		timer.start(0.05); yield(timer,"timeout")

func alt_second_attack():
	relocate_to(Vector2(576,200))
	for i in range(10):
		for j in range(3):
			if state == states.dying:
				return
			create_lasergun(Vector2(Game.get_player().global_position.x + (j-1)*220,50),90,0.45,0.05)
		timer.start(0.1); yield(timer,"timeout")
		launch_bloodball(darko.global_position,null,Game.get_player())
		timer.start(0.03); yield(timer,"timeout")

func alt_third_attack():
	var dir = (randi()%2)*2-1
	relocate_to(Vector2(576+dir*300,150),0.2)
	var missing = 4 if rand_range(0,100) > 70 else 3
	for i in range(5):
		if i != missing:
			create_lasergun(Vector2(576-dir*776,100+i*100),180+180*(dir+1)/2,0.75,0.25,Vector2(2,2))
	for i in range(7):
		create_lasergun(Vector2(((randi()%2)*2-1)*50+i*183,-100),90,0.75,0.25,Vector2(2,2))	
	timer.start(1.15); yield(timer,"timeout")
	for j in range(2):
		missing = 4 if rand_range(0,100) > 70 else 3
		for i in range(5):
			if i != missing:
				create_lasergun(Vector2(576-dir*776,100+i*100),180+180*(dir+1)/2,0.6,0.25,Vector2(2,2))
		for i in range(7):
			create_lasergun(Vector2(((randi()%2)*2-1)*50+i*183,-100),90,0.6,0.25,Vector2(2,2))	
		
		timer.start(1.0); yield(timer,"timeout")

func alt_fourth_attack():
	relocate_to(Vector2(576,50))
	yield(tween,"tween_completed")
	for i in range(5):
		if state == states.dying: return
		var rock = preload("res://bosses/darko/attacks/ancientrock/ancientrock.tscn").instance()
		rock.global_position = darko.global_position + Vector2(rand_range(-300,300),0)
		Game.get_world().add_child(rock)
		if rand_range(0,100) > 66:
			rock.launch_towards(Game.get_player().global_position)
			rock.direction = rock.direction.rotated(rand_range(-0.2,0.2))
		else:
			rock.launch_towards(Vector2([0,1152][randi()%2],rand_range(300,600)))
		timer.start(0.5); yield(timer,"timeout")
func alt_fifth_attack():
	var num := 6.0
	var rand = rand_range(-0.1,0.1)
	var ln := 40.0
	relocate_to(Vector2(1076,100),0.35)
	yield(tween,"tween_completed")
	bhm.origin.global_position = darko.global_position
	for i in range(num):
		if state == states.dying: return
		yield(get_tree().create_timer(0.05),"timeout")
		for j in range(ln):
			var bullet = bhm.spawn_bullet(100+pow((1+j/ln),1.8)*500,Vector2(0,1).rotated(PI/4+(i-num/2)/num*3*PI/4+rand))
			bullet.lifetime = lerp((ln-j)/ln,1,0.95)*7.6
	rand = rand_range(-0.1,0.1)
	relocate_to(Vector2(76,100),0.05)
	yield(tween,"tween_completed")
	bhm.origin.global_position = darko.global_position
	rand = rand_range(-0.1,0.1)
	for i in range(num):
		if state == states.dying: return
		yield(get_tree().create_timer(0.05),"timeout")
		for j in range(ln):
			var bullet = bhm.spawn_bullet(100+pow((1+j/ln),1.8)*500,Vector2(0,1).rotated(-PI/4+(-i+num/2)/num*3*PI/4+rand))
			bullet.lifetime = lerp((ln-j)/ln,1,0.95)*7.6
	
		
func relocate_to(pos,time = 0.2):
	tween.interpolate_property(darko,"global_position",darko.global_position,pos,time)
	tween.start()
func death():
	tween.stop_all()
	if Game.darko_phase == 1 and Game.fires_collected >= 14:
		Game.darko_phase = 2
		state = states.reviving
		animplayer.play("rebirth")
		Game.get_audio().play_music("darko2")
		timer.stop()
		tween.interpolate_property(darko,"global_position",darko.global_position,Vector2(576,224),0.2)
		tween.start()
		yield(animplayer,"animation_finished")
		_ready()
		return
	state = states.dying
	animplayer.stop()
	tween.stop_all()
	relocate_to(Vector2(576, 220),0.2)
	yield(tween,"tween_completed")
	animplayer.play("death")
	yield(animplayer,"animation_finished")
	queue_free()
	Game.complete()
func _process(delta):
	if Game.darko_phase == 2:
		shaderrect.get_material().set_shader_param("progress",pow(1-health/max_health,2))
	if state != states.dying and state != states.reviving:
		health -= delta
	healthbar.rect_size.x = 648*(health/max_health)
	if health <= 0 and state != states.dying and state != states.reviving:
		death()
	state_duration_left -= delta
	if state_duration_left <= 0:
		match state:
			states.idle:
				choose_attack()
				attack(current_attack)
				state = states.attacking
				state_duration_left = attack_duration[current_attack + (Game.darko_phase-1)*5]
			states.attacking:
				state = states.idle
				state_duration_left = idle_duration
func steal_fire():
	var fire = preload("res://other/ancientfire.tscn").instance()
	fire.get_node("Area2D").monitoring = false
	fire.global_position = Game.get_player().global_position
	Game.get_world().add_child(fire)
	fire.fly_to(darko.global_position)
