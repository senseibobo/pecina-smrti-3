extends Node2D

export var speed : float = 700
export var direction : Vector2 = Vector2(-16,-9)
export var disappearing : bool = false
export var rotation_speed : float = 8


func _process(delta):
	rotation += delta*rotation_speed
	position += direction.normalized()*speed*delta
	if not disappearing:	
		if global_position.x > 1200: global_position.x -= 1252
		if global_position.y > 700: global_position.y -= 748
		if global_position.x < -100: global_position.x += 1252
		if global_position.y < -100: global_position.y += 748
	else:
		var rct = Rect2(-50,-50,1250,750)
		if not rct.has_point(global_position+direction.normalized()*speed) and not rct.has_point(global_position):
			queue_free()

func _on_Area2D_body_entered(body):
	body.death()
	speed = 0
