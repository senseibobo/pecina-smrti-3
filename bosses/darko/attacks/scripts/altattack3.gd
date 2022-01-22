extends Attack

func _init():
	easy = {
		"pre_delay" : 0.4,
		"post_delay" : 0.0
	}
	hard = {
		"pre_delay" : 0.4,
		"post_delay" : 0.0
	}
	vars = [easy,hard][Game.difficulty]
	
func attack(boss): # best attack
	boss.relocate_to(Vector2(576,150),0.2)
	a(boss)
	yield(Tools.timer(1.15,boss),"timeout")
	for j in range(2):
		a(boss)
		yield(Tools.timer(1.0,boss),"timeout")
	boss.emit_signal("attack_finished")

func a(boss):
	var missing = 4 if rand_range(0,100) > 70 else 3
	for i in range(5): # horizontal lasers
		if i != missing:
			boss.create_lasergun(Vector2(-200,100+i*100),0,0.75,0.15,Vector2(2,2))
	var x = 0
	while x < 1152:
		x += 96
		x += randi()%3*80 
		boss.create_lasergun(Vector2(x,-100),90,0.75,0.15,Vector2(2,2))
