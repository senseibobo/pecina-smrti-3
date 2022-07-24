extends Control

enum Ending {
	Bad,
	Ok,
	Good,
	Best
}

func _ready():
	match get_ending():
		Ending.Bad: $AnimationPlayer.play("bad")
		Ending.Ok: $AnimationPlayer.play("neutral")
		
func get_ending():
	var rezultat = 0
	rezultat += int(State.state["fires_collected"] == 18)
	rezultat += int(State.state["difficulty"] == Game.DIFFICULTY.HARD)
	if rezultat == 2:
		rezultat += int(State.state["povez"])
	return Ending.values()[rezultat] 
