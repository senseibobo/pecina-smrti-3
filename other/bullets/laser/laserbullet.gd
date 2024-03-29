extends Bullet
class_name LaserBullet

var index : int

func _init():
	texture = preload("res://other/bullets/laser/laserbullet.png")
	size = texture.get_size() + Vector2(40,5)

func process(area_rid,delta,i):
	if lifetime > 8.3:
		speed = 0
	.process(area_rid,delta,i)

func get_modulate():
	var c = 1.7
	return Color(c,c,c,1)

func get_shape():
	var shape = Physics2DServer.rectangle_shape_create()
	Physics2DServer.shape_set_data(shape,Vector2(2.5,20))
	return shape

func set_transform(area_rid,i):
	var t = Transform2D(0,current_position)
	Physics2DServer.area_set_shape_transform(area_rid,i,t)
