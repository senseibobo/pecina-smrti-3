extends Attack

const spiked_pillar_scene = preload("res://bosses/pecinac/1/attacks/2/spikedpillar.tscn")
const step : float = 52.0

func _init():
	easy = {
		"pre_delay" : 0.5,
		"post_delay" : 1.2,
		"count" : 3
	}
	hard = {
		"pre_delay" : 0.4,
		"post_delay" : 1.1,
		"count" : 5
	}
	vars = [easy,hard][State.state["difficulty"]]

func attack(boss): # pillars
	boss.cast_spell(Color.blue)
	var pillars = []
	var xsteps : Array = []
	var ysteps : Array = []
	for i in range(vars["count"]):
		var x : float
		var y : float
		var pillar = spiked_pillar_scene.instance()
		var side = randi()%4
		var rotation = [0,PI/2,PI,-PI/2][side]
		var axis = ["x","y","x","y"][side]
		var direction = [Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT,Vector2.UP][side]
		var position : Vector2
		var player = Game.get_player().global_position
		if   side == 0: 
			x = 0
			y = closest_y_step(player,ysteps)
			ysteps.append(y)
		elif side == 1: 
			x = closest_x_step(player,xsteps)
			xsteps.append(x)
			y = 0
		elif side == 2:
			x = 1152.0/step
			y = closest_y_step(player,ysteps)
			ysteps.append(y)
		elif side == 3: 
			x = closest_x_step(player,xsteps)
			xsteps.append(x)
			y = 648.0/step
		pillar.rotation = rotation
		pillar.global_position = Vector2(x,y)*step
		boss.add_child(pillar)
		Tools.tween(
			pillar,
			"global_position",
			pillar.global_position,
			pillar.global_position+direction*1500,
			3.0,Tween.TRANS_QUAD,Tween.EASE_IN_OUT
		)
		pillars.append(pillar)
		Game.shake_screen(5,3.5)
		yield(Tools.timer(0.45,boss),"timeout")
	yield(Tools.timer(2.5,boss),"timeout")
	boss.stop_casting()
	boss.emit_signal("attack_finished")
	yield(Tools.timer(0.5,boss),"timeout")
	for pillar in pillars:
		pillar.death()
	Game.shake_screen(10,1)

func closest_x_step(position : Vector2, xsteps : Array):
	var tpos = round(position.x/step)
	var i = 0
	while true:
		if not tpos + i in xsteps: return tpos + i
		if not tpos - i in xsteps: return tpos - i
		i += 1
	
func closest_y_step(position : Vector2, ysteps : Array):
	var tpos = round(position.y/step)
	var i = 0
	while true:
		if not tpos - i in ysteps: return tpos - i
		if not tpos + i in ysteps: return tpos + i
		i += 1

	
