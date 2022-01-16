extends KinematicBody2D

var velocity : Vector2
export var gravity : float = 1000
export var max_velocity_y = 2400
export var weight = 10
export var immoveable : bool = false

onready var rightcast = $RightCast
onready var leftcast = $LeftCast

func _ready():
	if immoveable:
		rightcast.enabled = false
		leftcast.enabled = false

func _physics_process(delta):
	if immoveable: return
	var cl = leftcast.is_colliding()
	var cr = rightcast.is_colliding()
	velocity.x = (int(cl)-int(cr))*1000/weight
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity,Vector2(0,gravity).normalized())
	if global_position.y > 820: global_position.y = -100
	elif global_position.y < -120: global_position.y = 800
