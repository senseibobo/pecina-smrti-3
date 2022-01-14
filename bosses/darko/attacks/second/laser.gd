extends Line2D

var shot : bool = false

var prep = 0.75
var time = 0.75

func _ready():
	scale = Vector2(1,0.05)
	$Tween.interpolate_property(self,"modulate",Color(1.2,0,0,0.0),Color(1.3,0,0,1),prep-0.1,Tween.TRANS_SINE,Tween.EASE_OUT)
	$Tween.start()
	$Timer.start(prep); yield($Timer, "timeout")
	$Tween.interpolate_property(self,"scale",scale,Vector2(1,1),0.03)
	$Tween.start()
	modulate = Color(1.6,1,1,1)
	yield($Tween,"tween_completed")
	$Area2D/CollisionShape2D.call_deferred("set_disabled",false)
	Game.get_audio().laser_sound()
	shot = true
	$Timer.start(time); yield($Timer, "timeout")
	$Tween.interpolate_property(self,"scale",scale,Vector2(1,0),0.05)
	$Tween.start()
	yield($Tween,"tween_completed")
	death()

func _process(_delta):
	if shot:
		scale.y = rand_range(0.75,1.25)

func death():
	Game.get_audio().stop_laser()
	if get_parent().has_method("done"):
		get_parent().done()
	queue_free()

func _on_Area2D_body_entered(body):
	body.death()
