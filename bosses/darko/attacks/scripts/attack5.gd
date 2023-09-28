extends Attack

func _init():
	easy = {
		"pre_delay" : 0.2,
		"post_delay" : 0.2,
		"prep_time": 1.7,
		"laser_time": 3.0,
		"laser_count" : 4,
	}
	hard = {
		"pre_delay" : 0.2,
		"post_delay" : 0.2,
		"prep_time": 1.2,
		"laser_time": 2.5,
		"laser_count" : 5,
	}
	vars = [easy,hard][State.state["difficulty"]]


func attack(boss): #| | | | | | | laser
	yield(boss.relocate_to(Vector2(576,50),0.3),"tween_all_completed")
	
	var current_place = 0
	var offset = randi()%64
	var dir = randi()%2*2-1
	
	var node = Node2D.new()
	boss.get_tree().current_scene.add_child(node)
	var w = 1152.0/vars["laser_count"]
	
	for j in range(vars["laser_count"]+4):
		boss.create_lasergun(Vector2(offset+(j-2)*w,48),90,vars["prep_time"],vars["laser_time"],Vector2.ONE,node)
	
	var tween = boss.create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_interval(vars["prep_time"]/2.0)
	tween.tween_property(node,"global_position:x",(randi()%2*2-1)*1000.0/vars["laser_count"],vars["laser_time"]/2.0)
	tween.tween_property(node,"global_position:x",0.0,vars["laser_time"]/2.0)
	tween.tween_interval(vars["prep_time"]/2.0)
	yield(tween,"finished")
	boss.emit_signal("attack_finished")
