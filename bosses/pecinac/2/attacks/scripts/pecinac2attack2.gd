extends Attack

const laser_scene = preload("res://bosses/pecinac/2/attacks/lasereyes/laser.tscn")

func _init():
	easy = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
	}
	hard = {
		"pre_delay" : 0.2,
		"post_delay" : 0.5,
	}
	vars = [easy,hard][State.state["difficulty"]]

var time: float = 0.0
var mouth

func attack(boss):
	yield(boss.relocate_to(Vector2(rand_range(50,1102),rand_range(60,150))),"tween_all_completed")
	mouth = boss.boss_node.get_node_or_null("Head/Mouth")
	if mouth == null:
		mouth = boss.boss_node
	for i in 4:
		var pos = mouth.global_position
		for j in 3:
			var bloodball = boss.launch_bloodball(pos)
			bloodball.launch_at_angle(bloodball.rotation + rand_range(-0.2,0.2))
	yield(Tools.timer(0.3),"timeout")
	boss.emit_signal("attack_finished")
	
func process(delta,boss):
	boss.boss_node.global_position = (
		boss.boss_node.global_position.linear_interpolate(Vector2(576,200),8*delta)
	)

	

