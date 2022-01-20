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
	var dir = (randi()%2)*2-1
	boss.relocate_to(Vector2(576+dir*300,150),0.2)
	a(dir,boss)
	yield(Tools.timer(1.15,boss),"timeout")
	for j in range(2):
		a(dir,boss)
		yield(Tools.timer(1.0,boss),"timeout")
	boss.emit_signal("attack_finished")

func a(dir,boss):
	var missing = 4 if rand_range(0,100) > 70 else 3
	for i in range(5): # horizontal lasers
		if i != missing:
			boss.create_lasergun(Vector2(576-dir*776,100+i*100),180+180*(dir+1)/2,0.75,0.25,Vector2(2,2))
	missing = range(7)
	for i in range(4 if Game.difficulty == Game.DIFFICULTY.EASY else 3):
		missing.remove(randi()%missing.size())
	for i in range(7): # vertical lasers
		if not i in missing:
			boss.create_lasergun(Vector2(50+i*183,-100),90,0.75,0.25,Vector2(2,2))
