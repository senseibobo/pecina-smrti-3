extends Node2D

var bullets = []

onready var origin := $Origin as Position2D
onready var shared_area := $SharedArea as Area2D

export(Texture) var bullet_image

var time = 0

func spawn_bullet(speed,movement_vector,type = 1):
	var bullet = Bullet.new()
	bullet.movement_vector = movement_vector
	bullet.speed = speed
	bullet.current_position = origin.position
	bullet.type = type
	
	_configure_collision_for_bullet(bullet)
	
	bullets.append(bullet)
	return bullet
	
func _configure_collision_for_bullet(bullet: Bullet):
	var used_transform := Transform2D(0,position)
	used_transform.origin = bullet.current_position
	
	var circle_shape = Physics2DServer.circle_shape_create()
	Physics2DServer.shape_set_data(circle_shape,8)
	Physics2DServer.area_add_shape(shared_area.get_rid(),circle_shape,used_transform)
	
	bullet.shape_id = circle_shape

func _physics_process(delta):
	#time += delta
	#for i in range(10):
	#	spawn_bullet(400,Vector2(1,0).rotated(time*2.0+i*TAU/10.0))
	
	var bullets_queued_for_destruction := []
	
	for i in range(bullets.size()):
		var bullet = bullets[i] as Bullet
		var offset : Vector2 = bullet.movement_vector.normalized() * bullet.speed * delta/3.0
		if bullet.type == 0:
			bullet.speed = (200 + 700*pow(bullet.lifetime,4))
		bullet.current_position += offset
		bullet.lifetime += delta
		var t = Transform2D(0,bullet.current_position)
		Physics2DServer.area_set_shape_transform(shared_area.get_rid(),i,t)
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
		var color : Color = Color()
		draw_texture_rect(
			bullet_image,
			Rect2(bullet.current_position,Vector2(20,20)),
			false,
			(Color(1.2,1.2,1.2,bullet.lifetime/2.3+0.8) if bullet.type == 0 else 
			 Color(2.0,2.0,2.0,1.0))
		)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


func _on_SharedArea_body_entered(body):
	body.death()
