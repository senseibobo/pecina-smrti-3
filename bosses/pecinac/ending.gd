extends Control

enum Ending {
	Bad,
	BadPovez,
	Ok,
	OkPovez,
	Good,
	Best
}

func _ready():
	#debug()
	var cr = ColorRect.new()
	add_child(cr)
	cr.anchor_right = 1.0
	cr.anchor_bottom = 1.0
	cr.color = Color.white
	yield(Tools.timer(1.5),"timeout")
	Tools.tween(cr,"color",Color.white,Color(1.0,1.0,1.0,0.0),0.5)
	match get_ending():
		Ending.BadPovez: $AnimationPlayer.play("badpovez")
		Ending.OkPovez: $AnimationPlayer.play("neutralpovez")
		Ending.Bad: $AnimationPlayer.play("bad")
		Ending.Ok: $AnimationPlayer.play("neutral")
		Ending.Good: $AnimationPlayer.play("good")
		Ending.Best: $AnimationPlayer.play("best")

func debug():
	State.state["povez"] = true
	State.state["fires_collected"] = 18
	State.state["difficulty"] = Game.DIFFICULTY.HARD

func get_ending():
	var rezultat = 0
	rezultat += int(State.state["fires_collected"] == 18)
	rezultat += int(State.state["difficulty"] == Game.DIFFICULTY.HARD)
	if rezultat == 2:
		return Ending.Best if State.state["povez"] else Ending.Good
	elif rezultat == 1:
		return Ending.OkPovez if State.state["povez"] else Ending.Ok
	elif rezultat == 0:
		return Ending.BadPovez if State.state["povez"] else Ending.Bad
	return Ending.Best
