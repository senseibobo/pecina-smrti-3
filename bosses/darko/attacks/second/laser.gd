extends Area2D

signal shot

var shot : bool = false

var prep = 0.75
var time = 0.75

onready var line1 = $Lines/Line1
onready var line2 = $Lines/Line2
onready var lines = $Lines
onready var collision = $CollisionShape2D


#prep time
#launch time
#firing time
#death

func _ready():
	print("this is coming fom a laser")
	#prep time:
	$Lines.scale = Vector2(1,0.05)
	yield(Tools.timer(prep), "timeout")
	
	#launch time:
	var tween = create_tween()
	Audio.laser_sound()
	tween.tween_property(lines,"scale",Vector2(1,1),0.03)
	modulate = Color(1.6,1,1,1)
	yield(tween,"finished")
	
	#firing time
	collision.set_deferred("disabled",false)
	emit_signal("shot")
	shot = true
	yield(Tools.timer(time), "timeout")
	
	#death
	collision.set_deferred("disabled",true)
	tween = create_tween()
	tween.tween_property(lines,"scale",Vector2(1,0),0.05)
	tween.tween_callback(self,"death")

func _process(_delta):
	if shot:
		$Lines.scale.y = rand_range(0.75,1.25)
		
func death():
	Audio.stop_laser()
	if get_parent().has_method("done"):
		get_parent().done()
	queue_free()

func body_entered(body):
	body.death()
