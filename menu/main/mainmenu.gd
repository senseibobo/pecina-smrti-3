extends Control


func _ready():
	pass


func easy():
	Game.difficulty = Game.DIFFICULTY.EASY
	Game.start_game()



func hard():
	Game.difficulty = Game.DIFFICULTY.HARD
	Game.start_game()
