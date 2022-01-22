extends KinematicBody2D

class_name Player

const SPEED : float = 400.0
const GRAVITY : float = 1350.0
const JUMP_FORCE : float = 585.0
const MAX_VELOCITY_Y : float = 2400.0

onready var current_speed : float = SPEED
onready var sprite = $Sprite

var frozen : bool = true
var dying : bool = false
var unkillable : bool = false

var vec_up = Vector2.UP
var velocity : Vector2
var old_wall : bool = false
var old_move : float = 0

var fires_collected : int = 0

func _ready():
	start()

func start():
	SceneManager.connect("transition_complete",self,"_transition_complete")
	SceneManager.connect("transition_started",self,"_transition_started")
	$Timer.start(0.4); yield($Timer,"timeout")
	frozen = false

func _transition_started():
	frozen = true
	
func _transition_complete():
	frozen = false

func _physics_process(delta):
	_movement(delta)
	_sprites()
	global_position.y = wrapf(global_position.y,-100,820)
	if global_position.x > 1200 and not SceneManager.transitioning:
		Game.pass_level()
		unkillable = true
		Game.fires_collected += fires_collected

func flip_gravity():
	vec_up = -vec_up
	rotation += PI

func _sprites():
	sprite.frame = int(is_on_ceiling())
	var move = Input.get_axis("move_left","move_right")
	if move != 0:
		sprite.scale.x = abs(sprite.scale.x)*move

func _movement(delta):
	if frozen: return
	var move = Input.get_axis("move_left","move_right")
	
	velocity.x = current_speed*move
	velocity.y = clamp(velocity.y - (GRAVITY*vec_up.y)*delta, -MAX_VELOCITY_Y, MAX_VELOCITY_Y)
	
	if is_on_ceiling():
		velocity.y = vec_up.y*10
		if Input.is_action_pressed("move_down"):
			velocity.y = -vec_up.y
			
	old_wall = is_on_wall()
	var _result_velocity = move_and_slide(velocity,vec_up)
	if old_wall and !is_on_wall() and move != 0 and old_move == move and -vec_up.y * velocity.y > 0 and test_move(transform,Vector2(0,-velocity.y-1)):
		move_and_collide(vec_up*abs(velocity.y)*delta)
		velocity.y = -velocity.y
	old_move = move
	
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_pressed("move_up"): 
			velocity.y = vec_up.y*JUMP_FORCE
		
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		
		if collision.collider.is_in_group("Box"):
			collision.collider.velocity -= collision.normal*10000
		
		if collision.collider.is_in_group("Death"):
			death()
	
			
func death():
	if dying or unkillable: return
	dying = true
	frozen = true
	Game.deaths += 1
	Game.emit_signal("player_death")
	Game.update_deaths()
	Game.shake_screen(20,0.7)
	$Timer.start(0.15); yield($Timer,"timeout")
	Game.restart_level()
	Audio.death_sound()
