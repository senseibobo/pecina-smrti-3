class_name Bullet
extends Reference

var shape_id : RID
var movement_vector : Vector2
var current_position : Vector2
var lifetime : float = 0.0
var image_offset : int = 0
var layer : String = "front"
var speed : float
var modulate : Color
var texture : Texture
var rotation : float
var size : Vector2 = Vector2(10,10)

func get_modulate():
	return Color(1,1,1,1)

func process(area_rid,delta,i):
	var offset : Vector2 = movement_vector.normalized() * speed * delta/3.0
	current_position += offset
	lifetime += delta
	set_transform(area_rid,i)

func configure_collision(area_rid):
	var used_transform := Transform2D(0,current_position)
	used_transform.origin = current_position
	
	var shape = get_shape()
	Physics2DServer.area_add_shape(area_rid,shape,used_transform)
	
	shape_id = shape

func get_shape():
	var circle_shape = Physics2DServer.circle_shape_create()
	Physics2DServer.shape_set_data(circle_shape,8)
	return circle_shape

func set_transform(area_rid,i):
	var t = Transform2D(0,current_position)
	Physics2DServer.area_set_shape_transform(area_rid,i,t)

func rotate():
	rotation = movement_vector.angle()
