extends Particles2D


func _ready():
	emitting = true
	yield(get_tree().create_timer(3,false),"timeout")
	queue_free()
