extends Area2D

var shot : bool = false

var prep = 0.75
var time = 0.75

onready var line1 = $Lines/Line1
onready var line2 = $Lines/Line2
onready var lines = $Lines
onready var tween = $Tween
onready var timer = $Timer
onready var collision = $CollisionShape2D

func _ready():
	scale = Vector2(1,0.05)
	timer.start(prep); yield(timer, "timeout")
	tween.interpolate_property(lines,"scale",scale,Vector2(1,1),0.03)
	tween.start()
	modulate = Color(1.6,1,1,1)
	yield(tween,"tween_completed")
	collision.call_deferred("set_disabled",false)
	Audio.laser_sound()
	shot = true
	timer.start(time); yield(timer, "timeout")
	tween.interpolate_property(lines,"scale",scale,Vector2(1,0),0.05)
	tween.start()
	yield(tween,"tween_completed")
	death()

func _process(_delta):
	if shot:
		scale.y = rand_range(0.75,1.25)

func death():
	Audio.stop_laser()
	if get_parent().has_method("done"):
		get_parent().done()
	queue_free()

func body_entered(body):
	body.death()
