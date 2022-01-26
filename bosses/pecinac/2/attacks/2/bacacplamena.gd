extends Area2D

signal shot
signal done
signal stopped

var shot := false

func _ready():
	warning()
	yield(Tools.timer(0.25,self),"timeout")
	Game.shake_screen(5,2.0)
	$CollisionShape2D.set_deferred("disabled",false)
	Tools.tween($CollisionShape2D,"position",Vector2(0,0),Vector2(400,0),0.8)
	Tools.tween($CollisionShape2D.shape,"extents",Vector2(0,0),Vector2(400,43),0.8)
	$Particles2D.emitting = true
	shot = true
	emit_signal("shot")
	yield(Tools.timer(2.0,self),"timeout")
	$Particles2D.emitting = false
	$CollisionShape2D.set_deferred("disabled",true)
	emit_signal("stopped")
	yield(Tools.timer($Particles2D.lifetime,self),"timeout")
	emit_signal("done")
	queue_free()
	
func warning():
	$Sprite.global_rotation = 0
	while not shot:
		$Sprite.visible = true
		yield(Tools.timer(0.06,self),"timeout")
		$Sprite.visible = false
		yield(Tools.timer(0.06,self),"timeout")

func _body_entered(body):
	body.death()
