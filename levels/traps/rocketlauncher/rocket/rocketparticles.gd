extends Particles2D

func queue_death():
	var timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true
	add_child(timer)
	timer.start(2.5); yield(timer,"timeout")
	queue_free()
