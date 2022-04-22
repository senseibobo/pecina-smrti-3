extends Attack

const laser_scene = preload("res://bosses/pecinac/2/attacks/lasereyes/laser.tscn")

func _init():
	easy = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
	}
	hard = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
	}
	vars = [easy,hard][Game.difficulty]

var time: float = 0.0
var laser_rotation: float = 0.0
var laser1
var laser2
var eye1
var eye2

func attack(boss):
	eye1 = boss.boss_node.get_node("Head/Eye1")
	eye2 = boss.boss_node.get_node("Head/Eye2")
	laser1 = laser_scene.instance()
	laser1.set_as_toplevel(true)
	eye1.add_child(laser1)
	laser2 = laser_scene.instance()
	laser2.set_as_toplevel(true)
	eye2.add_child(laser2)
	#boss.emit_signal("attack_finished")

var phase = rand_range(0,TAU)
var frequency = rand_range(1.05,1.15)

func process(delta,boss):
	time += delta
	boss.boss_node.global_position.x = sin(time)*476 + 576
	boss.boss_node.global_position.y = 100+sin(time*1.5)*60
	var dest = Vector2(sin(time*frequency+phase)*476+576,600)
	laser_rotation = dest.angle_to_point(boss.boss_node.global_position)
	if is_instance_valid(laser1):
		laser1.rotation = laser_rotation+0.13
		laser2.rotation = laser_rotation-0.13
		laser1.global_position = eye1.global_position
		laser2.global_position = eye2.global_position

	

