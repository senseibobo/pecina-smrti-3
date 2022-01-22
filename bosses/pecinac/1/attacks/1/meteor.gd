extends Area2D

signal destroyed
signal assembled
signal part_added

var part_count : int
var speed : float = 0.0
var acceleration : float = 1200.0
var direction : Vector2
var assembled : bool = false

func _ready():
	Game.shake_screen(7,0.5)
	rotation = rand_range(0,TAU)
	var parts = $delovi.get_children()
	part_count = parts.size()
	for part in parts:
		var old_position = part.global_position
		part.global_position = Vector2.RIGHT.rotated(rand_range(0,TAU))*1300
		part.visible = true
		var tween = Tools.tween(part,"global_position",part.global_position,old_position,1.0+rand_range(-0.5,0.5),Tween.TRANS_CUBIC,Tween.EASE_IN)
		tween.connect("tween_all_completed",self,"part_added")

func _physics_process(delta):
	if assembled:
		speed += acceleration*delta
		global_position += direction*speed*delta

func part_added():
	part_count -= 1
	Game.shake_screen(12+(10-part_count),0.2)
	if part_count == 0:
		assembled()
	emit_signal("part_added")

func assembled():
	assembled = true
	Game.shake_screen(22,1)
	$Sprite.visible = true
	$delovi.queue_free()
	$Particles.emitting = true
	$CollisionPolygon2D.set_deferred("disabled",false)
	emit_signal("assembled")


func exited():
	queue_free()
	emit_signal("destroyed")


func body_entered(body):
	body.death()
