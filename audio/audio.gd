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

func play_music(music_name : String = "paradox"):
	stop()
	stream = music[music_name]
	play()
	current_song = music_name
	if current_song == "darko2":
		seek(37)
	
func _ready():
	play_music("paradox")
	for i in range(1,11):
		death_sfx.append(load("res://audio/sfx/death/death%s.wav"%str(i)))
	laser_sound.loop = true

func death_sound():
	sfx.stop()
	sfx.stream = death_sfx[randi()%10]
	sfx.play()
	pass

func explosion_sound():
	sfx.stop()
	var explosion = preload("res://audio/sfx/explosion/sn_explosion.ogg")
	explosion.loop = false
	sfx.stream = explosion
	sfx.play()
	pass
	
func laser_sound():
	laser_count += 1
	if laser_count == 1:
		sfx.stream = laser_sound
		if not sfx.playing:
			sfx.play()
	pass

func stop_laser():
	laser_count -= 1
	if laser_count == 0:
		sfx.stop()

func _process(_delta):
	sfx.volume_db = volume_db
	match current_song:
		"darko": 
			if get_playback_position() > 135.4: seek(28.7)
		"paradox": 
			if get_playback_position() > 197.2: seek(88.12)
		"darko2":
			if get_playback_position() > 181.3: seek(53.35)
