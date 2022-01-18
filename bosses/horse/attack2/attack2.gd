var pre_delay := 0.0
var post_delay := 1.0
const distance := 200.0
const jump_time := 0.15
const fall_time := 0.5
const delay := 0.2
const jumps := 10
const screenshake := 50.0
const jump_height := 120.0
func attack(horse):
	for i in range(jumps):
		var new_horse_x := rand_range(50,1102)
		
		yield(Tools.timer(delay),"timeout")
		
		yield(Tools.tween(
			horse,
			"global_position",
			horse.global_position,
			Vector2(new_horse_x,jump_height),
			jump_time,
			Tween.TRANS_CIRC,
			Tween.EASE_OUT
		),"tween_all_completed")
		
		yield(Tools.tween(
			horse,
			"global_position",
			horse.global_position,
			Vector2(new_horse_x,488),
			fall_time,
			Tween.TRANS_CIRC,
			Tween.EASE_IN
		),"tween_all_completed")
		
		Game.shake_screen(screenshake,1)
		
	Tools.emit_signal("attack_finished")
