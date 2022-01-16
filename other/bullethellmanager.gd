extends Node2D

var bullets = []

onready var origin := $Origin as Position2D
onready var shared_area := $SharedArea as Area2D

export(Texture) var bullet_image

var time = 0

func spawn_bullet(bullet,speed,movement_vector,type = 1):
	bullet.movement_vector = movement_vector
	bullet.speed = speed
	bullet.current_position = origin.position
	bullet.rotate()
	
	_configure_collision_for_bullet(bullet)
	
	bullets.append(bullet)
	return bullet
	
func _configure_collision_for_bullet(bullet):
	bullet.configure_collision(shared_area.get_rid())

func _physics_process(delta):
	#time += delta
	#for i in range(10):
	#	spawn_bullet(400,Vector2(1,0).rotated(time*2.0+i*TAU/10.0))
	
	var bullets_queued_for_destruction := []
	
	for i in range(bullets.size()):
		var bullet = bullets[i]
		bullet.process(shared_area.get_rid(),delta,i)
		if bullet.lifetime > 10.0 or not Rect2(-100,-100,1300,800).has_point(bullet.current_position): 
			bullets_queued_for_destruction.append(bullet)
	for bullet in bullets_queued_for_destruction:
		Physics2DServer.free_rid(bullet.shape_id)
		bullets.erase(bullet)
	bullets_queued_for_destruction = []
	update()

func _draw() -> void:
	var offset = bullet_image.get_size() / 2.0
	for bullet in bullets:
		draw_set_transform(bullet.current_position,bullet.rotation,Vector2(1,1))
		draw_texture_rect(
			bullet.texture,
			Rect2(Vector2(),bullet.size),
			false,
			bullet.get_modulate()
		)
		 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


func _on_SharedArea_body_entered(body):
	body.death()
