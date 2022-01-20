extends Node2D

var prep : float
var time : float

func _ready():
	var laser = preload("res://bosses/darko/attacks/second/laser.tscn").instance()
	laser.position = $shootpos.position
	laser.prep = prep
	laser.time = time
	add_child(laser)
	laser.connect("shot",self,"shot")
	$Particles2D.emitting = true

func shot():
	$Sprite.frame = 2
	while true:
		yield(Tools.timer(0.06,self),"timeout")
		$Sprite.frame = int(not bool($Sprite.frame-2))+2

func done():
	queue_free()
