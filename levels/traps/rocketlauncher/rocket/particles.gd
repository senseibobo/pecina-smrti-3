extends Particles2D
class_name GameParticles

func queue_death(time : float = 2.5):
	var timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true
	add_child(timer)
	timer.start(time); yield(timer,"timeout")
	queue_free()
