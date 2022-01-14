extends Sprite


onready var player : Player = Game.get_player()

func _process(delta):
	position.x = -player.position.x/30.0 + 700
