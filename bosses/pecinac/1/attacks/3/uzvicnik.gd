extends Sprite

var timer : float = 0.0

func _ready():
	yield(Tools.timer(1.0),"timeout")
	queue_free()

func _process(delta):
	timer += delta
	if timer > 0.2:
		timer = 0
		visible = !visible
