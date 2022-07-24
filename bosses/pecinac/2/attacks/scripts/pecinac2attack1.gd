extends Attack

const laser_scene = preload("res://bosses/pecinac/2/attacks/lasereyes/laser.tscn")

func _init():
	easy = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
		"wait_time": 1.4
	}
	hard = {
		"pre_delay" : 0.0,
		"post_delay" : 0.0,
		"wait_time": 0.9
	}
	vars = [easy,hard][State.state["difficulty"]]

var time: float = 0.0
var laser_rotation: float = 0.0
var laser1
var laser2
var eye1
var eye2

func attack(boss):
	for i in 2:
		var worm = preload("res://bosses/pecinac/2/attacks/worm/worm.tscn").instance()
		yield(boss.relocate_to(Vector2(576,200)),"tween_all_completed")
		yield(Tools.timer(0.2),"timeout")
		boss.add_child(worm)
		worm.generate_positions(boss.boss_node.get_node("Head/Eye"+str(i+1)).global_position)
#	eye1 = boss.boss_node.get_node("Head/Eye1")
#	eye2 = boss.boss_node.get_node("Head/Eye2")
#	laser1 = laser_scene.instance()
#	laser1.set_as_toplevel(true)
#	eye1.add_child(laser1)
#	laser2 = laser_scene.instance()
#	laser2.set_as_toplevel(true)
#	eye2.add_child(laser2)
	yield(Tools.timer(vars["wait_time"]),"timeout")
#	laser1.queue_free()
#	laser2.queue_free()
	boss.emit_signal("attack_finished")

var phase = rand_range(0,TAU)
var frequency = rand_range(1.05,1.15)

var dest = Vector2(576,900)

func process(delta,boss):
	time += delta
#	var pos = Vector2()
#	pos.x = sin(time)*476 + 576
#	pos.y = 100+sin(time*1.5)*60
#
#	boss.boss_node.global_position = (
#		boss.boss_node.global_position.linear_interpolate(pos,8*delta)
#	)
	dest = lerp(dest,Game.get_player().global_position,8*delta)#Vector2(sin(time*frequency+phase)*476+576,600)
	laser_rotation = dest.angle_to_point(boss.boss_node.global_position)
	if is_instance_valid(laser1):
		laser1.rotation = laser_rotation+0.13
		laser2.rotation = laser_rotation-0.13
		laser1.global_position = eye1.global_position
		laser2.global_position = eye2.global_position

	

