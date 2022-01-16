extends Bullet
class_name NormalBullet

func _init():
	texture = preload("res://other/bullets/laser/laserbullet.png")

func get_modulate():
	return Color(1.2,1.2,1.2,lifetime/2.3+0.8)

func process(area_rid,delta,i):
	speed = (200 + 700*pow(lifetime,4))
	.process(area_rid,delta,i)
