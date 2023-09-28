extends Node

const default_state = {
	"boss_phase" : {
		"darko" : 1,
		"pecinac" : 1
	},
	"current_level":1,
	"povez" : false,
	"deaths" : 0,
	"fires_collected" : 0,
	"time" : 0.0,
	"difficulty" : Game.DIFFICULTY.HARD
}

var state = default_state.duplicate(true)

func save_game():
	var string = JSON.print(state)
	var file = File.new()
	file.open("user://save.pecinasmrtisavefile",File.WRITE)
	file.store_string(string)
	file.close()

func load_game():
	var file = File.new()
	var error = file.open("user://save.pecinasmrtisavefile",File.READ)
	if error != OK:
		new_game()
	else:
		var string = file.get_as_text()
		state = JSON.parse(string).result
		file.close()
		
func new_game():
	state = default_state.duplicate(true)

func save_exists():
	var file = File.new()
	return file.file_exists("user://save.pecinasmrtisavefile")
