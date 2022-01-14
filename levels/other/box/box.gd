extends KinematicBody2D

var velocity : Vector2
export var gravity : float = 1000
export var max_velocity_y = 2400
export var weight = 10
export var immoveable : bool = false
var current_velocity_y : float = 0

onready var rightcast = $RightCast
onready var leftcast = $LeftCast
onready var upcast = $UpCast
onready var downcast = $DownCast

func _ready():
	if immoveable:
		rightcast.enabled = false
		leftcast.enabled = false
		upcast.enabled = false
		downcast.enabled = false

func _physics_process(delta):
	if immoveable: return
	current_velocity_y = clamp(current_velocity_y+gravity*delta,-max_velocity_y,max_velocity_y)
	var cu = upcast.is_colliding()
	var cd = downcast.is_colliding()
	var cl = leftcast.is_colliding()
	var cr = rightcast.is_colliding()
	velocity.y = current_velocity_y + (int(cu)-int(cd))*1000/weight
	velocity.x = (int(cl)-int(cr))*1000/weight
	velocity = move_and_slide(velocity,Vector2(0,gravity).normalized())
	current_velocity_y = velocity.y
	if global_position.y > 820: global_position.y = -100
	elif global_position.y < -120: global_position.y = 800
