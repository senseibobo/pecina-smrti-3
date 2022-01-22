extends Node2D


func death():
	var particles = $GameParticles
	particles.emitting = true
	yield(Tools.timer(0.1,self),"timeout")
	$TileMap.queue_free()
	$Spikes.queue_free()
	yield(Tools.timer(2.5,self),"timeout")
	queue_free()
