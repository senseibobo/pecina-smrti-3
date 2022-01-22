extends Area2D


var direction : Vector2
var speed : float = -300
var enabled : bool = false
var hit : bool = false

func _physics_process(delta):
	if not hit:
		speed += 3000*delta
		global_position += direction*speed*delta
		
func die():
	yield(Tools.timer(2.5),"timeout")
	$CollisionPolygon2D.set_deferred("disabled",true)
	set_physics_process(false)
	set_physics_process_internal(false)
	yield(Tools.tween(self,"global_position",global_position,global_position + Vector2.DOWN*120,0.3),"tween_all_completed")
	queue_free()


func hit(body):
	if body is Player:
		body.death()
	elif speed > 300:
		Game.shake_screen(5,0.3)
		$GameParticles.emitting = true
		hit = true
		speed = 0
		die()
