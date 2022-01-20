extends Attack

func _init():
	easy = {
		"pre_delay" : 0.5,
		"post_delay" : 2.0
	}
	hard = {
		"pre_delay" : 0.5,
		"post_delay" : 2.0
	}
	vars = [easy,hard][Game.difficulty]
func attack(boss):
	var num := 12.0
	var rand = rand_range(-0.1,0.1)
	var ln := 25.0
	yield(boss.relocate_to(Vector2(1076,100),0.35),"tween_all_completed")
	boss.relocate_to(Vector2(76,100),num*0.05)
	for i in range(num):
		yield(Tools.timer(0.05,boss),"timeout")
		boss.bhm.origin.global_position = boss.boss_node.global_position
		for j in range(ln):
			var speed = (pow((1+j/ln),2.3)-1)*500-700
			var bullet = boss.bhm.spawn_bullet(LaserBullet.new(),speed,Vector2(0,1).rotated((i-num/1.8)/(num)))
			bullet.lifetime = lerp((ln-j)/ln,1,0.95)*7.6
			bullet.index = j
	rand = rand_range(-0.1,0.1)
	boss.relocate_to(Vector2(1076,100),num*0.05)
	for i in range(num):
		yield(Tools.timer(0.05,boss),"timeout")
		boss.bhm.origin.global_position = boss.boss_node.global_position
		for j in range(ln):
			var speed = (pow((1+j/ln),2.3)-1)*500-700
			var bullet = boss.bhm.spawn_bullet(LaserBullet.new(),speed,Vector2(0,1).rotated((-i+num/2)/(num)))
			var p = int(j)%2
			bullet.lifetime = lerp((ln-j)/ln,1,0.95)*7.6
			bullet.index = j
	boss.emit_signal("attack_finished")
