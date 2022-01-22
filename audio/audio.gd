extends AudioStreamPlayer

onready var sfx = $SoundEffects as AudioStreamPlayer

var death_sfx = []
onready var laser_sound = preload("res://audio/sfx/laser/laser.ogg")
const default_music = preload("res://audio/music/paradox.ogg")

var laser_count : int = 0

var loop_start : float = 0.0
var loop_end : float = 0.0
var looping : bool = false

var current_music : String

func reset():
	laser_count = 0
	sfx.stop()

var song_start_positions = {
	"paradox" : 0,
	"darko" : 0,
	"darko2" : 37
}

var music = {
	"paradox" : "res://audio/music/paradox.ogg",
	"murder_machine" : "res://audio/music/murder_machine.ogg",
	"the_fear" : "res://audio/music/the_fear.ogg"
}

func play_music(music : String, start_position : float = 0.0, loop = false, start = 0, end = 0):
	if music != current_music:
		stop()
		stream = load(self.music[music])
		play(start_position)
		looping = loop
		loop_start = start
		loop_end = end
		current_music = music
	
	
func _ready():
	Audio.set_volume_db(-28.75)
	if not Game.current_level in [15,25]:
		call_deferred("play_music","paradox",0,true,88.12,197.2)
	for i in range(1,11):
		death_sfx.append(load("res://audio/sfx/death/death%s.wav"%str(i)))

func death_sound():
	sfx.stop()
	sfx.stream = death_sfx[randi()%10]
	sfx.play()

func play_sound(sound):
	sfx.stop()
	sfx.stream = sound
	sfx.play()

func laser_sound():
	laser_count += 1
	if laser_count == 1:
		sfx.stream = laser_sound
		if not sfx.playing:
			sfx.play()

func stop_laser():
	laser_count -= 1
	if laser_count == 0:
		sfx.stop()

var song_loop_positions = {
	"paradox" : {"start" : 88.12, "end" : 197.2},
	"darko" : {"start" : 28.7, "end" : 135.4},
	"darko2" : {"start" : 53.35, "end" : 181.3}
}

func get_level_music(level):
	if not level in [15,25]:
		return "paradox"
	return ""

func _process(_delta):
	sfx.volume_db = volume_db
	if looping and get_playback_position() > loop_end:
		seek(loop_start)
