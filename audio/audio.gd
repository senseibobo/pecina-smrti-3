extends AudioStreamPlayer

var current_song = ""

onready var sfx = $SoundEffects as AudioStreamPlayer

var death_sfx = []
onready var laser_sound = preload("res://audio/sfx/laser/laser.ogg")
onready var music = {
	"darko" : preload("res://audio/music/the_fear.ogg"),
	"darko2" : preload("res://audio/music/murder_machine.ogg"),
	"paradox" : preload("res://audio/music/paradox.ogg")
}

var laser_count : int = 0

func reset():
	laser_count = 0
	sfx.stop()

var song_start_positions = {
	"paradox" : 0,
	"darko" : 0,
	"darko2" : 37
}

func play_music(music_name : String = "paradox"):
	stop()
	stream = music[music_name]
	play()
	current_song = music_name
	seek(song_start_positions[current_song])
	
func _ready():
	play_music("paradox")
	for i in range(1,11):
		death_sfx.append(load("res://audio/sfx/death/death%s.wav"%str(i)))
	laser_sound.loop = true

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

func _process(_delta):
	sfx.volume_db = volume_db
	if get_playback_position() > song_loop_positions[current_song]["end"]:
		seek(song_loop_positions[current_song]["start"])
