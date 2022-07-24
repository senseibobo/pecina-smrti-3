extends Attack

var meteor_scene = preload("res://bosses/pecinac/1/attacks/1/meteor.tscn")

func _init():
	easy = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
		"avg_multiplier": 0.6
	}
	hard = {
		"pre_delay" : 0.5,
		"post_delay" : 1.0,
		"avg_multiplier": 1.2
	}
	vars = [easy,hard][State.state["difficulty"]]

var player_average_velocity : Vector2 = Vector2()
var done := false
var c : float = 0.0

func attack(boss): # meteor
	boss.cast_spell(Color.aqua)
	var meteor = meteor_scene.instance()
	meteor.global_position = boss.boss_node.global_position + Vector2.RIGHT.rotated(rand_range(0,TAU))*100 + Vector2.UP*120.0
	boss.add_child(meteor)
	calculate_average_velocity(boss)
	yield(meteor,"assembled")
	var player = Game.get_player()
	done = true
	player_average_velocity = player_average_velocity/c
	var dest = player.global_position + player_average_velocity*0.75
	meteor.direction = meteor.global_position.direction_to(dest)
	boss.stop_casting()
	boss.emit_signal("attack_finished")

func calculate_average_velocity(boss):
	var player = Game.get_player()
	while not done:
		yield(Tools.timer(0.08,boss),"timeout")
		c+=1.0
		player_average_velocity += player.velocity*vars["avg_multiplier"]

	
