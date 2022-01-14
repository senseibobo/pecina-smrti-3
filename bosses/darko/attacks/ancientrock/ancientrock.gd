extends Projectile

var max_speed : float = 750
var acceleration : float = 750

onready var sprite = $Sprite

func _ready():
	connect("hit",self,"create_rocklets")

func create_rocklets():
	for i in range(2):
		var dir = i*2-1
		for j in range(3):
			var rocklet = preload("res://bosses/darko/attacks/ancientrock/rocklet/rocklet.tscn").instance()
			rocklet.velocity = Vector2(dir*300,-150-j*150)
			rocklet.global_position = global_position
			get_parent().call_deferred("add_child",rocklet)

func _physics_process(delta):
	speed = move_toward(speed,max_speed,acceleration*delta)
	sprite.rotation += delta*3.0



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
