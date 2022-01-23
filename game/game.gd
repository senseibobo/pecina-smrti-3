extends Node

enum DIFFICULTY {
	EASY,
	HARD
}

signal scene_changed
signal player_death
signal level_passed

var current_level : int = 1
var deaths : int = 0
var fires_collected : int = 0
var difficulty : int = DIFFICULTY.HARD

const LEVEL_COUNT : int = 20

onready var hud_scene = preload("res://menu/hud/hud.tscn")
onready var pause_scene = preload("res://menu/pause/pause.tscn")
onready var camera_scene = preload("res://game/camera.tscn")
onready var mobilecontrols_scene = preload("res://other/mobilecontrols.tscn")

var hud
var pause
var camera
var mobilecontrols

var boss_phase = {
	"darko" : 2,
	"pecinac" : 2
}

func _ready():
	randomize()

func return_to_main_menu():
	yield(SceneManager.transition_to(load("res://menu/main/mainmenu.tscn")),"transitioned")
	get_tree().paused = false
	hud.queue_free()
	camera.queue_free()
	pause.queue_free()

func start_game(level : int = 1):
	current_level = level
	yield(SceneManager.transition_to(load("res://levels/level%d.tscn" % level)),"transitioned")
	hud = hud_scene.instance()
	pause = pause_scene.instance()
	camera = camera_scene.instance()
	if OS.get_name() in ["Android","iOS","HTML5"]:
		mobilecontrols = mobilecontrols_scene.instance()
		hud.add_child(mobilecontrols)
	add_child(hud)
	add_child(pause)
	add_child(camera)
	
	Audio.play_music(Audio.get_level_music(1))

func complete():
	hud.stopped = true
	yield(get_tree().create_timer(1.0,false),"timeout")
	var timerlabel = hud.get_node("Control/TimerLabel")
	timerlabel.rect_position = Vector2(425,274)
	timerlabel.align = HALIGN_CENTER
	timerlabel.rect_scale = Vector2(1.5,1.5)
	var smrtilabel = hud.get_node("Control/SmrtiLabel")
	smrtilabel.rect_position = Vector2(505,354)
	smrtilabel.align = HALIGN_CENTER
	hud.get_node("Control/LevelLabel").queue_free()

func restart_level():
	SceneManager.set_current_scene(load("res://levels/level%s.tscn"%str(current_level)))
	create_death_particles()
	
func pass_level():
	current_level += 1
	var music = Audio.get_level_music(current_level)
	if music != "":
		Audio.play_music(music)
	SceneManager.transition_to(load("res://levels/level%s.tscn"%str(current_level)))
	emit_signal("level_passed")


func update_deaths():
	if is_instance_valid(hud):
		hud.update_deaths()

func update_level():
	if is_instance_valid(hud):
		hud.update_level()

func get_player() -> KinematicBody2D:
	var player = get_node_or_null("/root/World/Player") as KinematicBody2D
	return player

func get_player_position() -> KinematicBody2D:
	var player = get_player()
	return player.global_position

func create_death_particles():
	var player = get_player()
	var death = preload("res://managers/particles/playerdeath.tscn").instance()
	var blood = preload("res://managers/particles/playerblood.tscn").instance()
	death.set_name("DEATH%s"%str(deaths))
	blood.set_name("BLOOD%s"%str(deaths))
	death.global_position = player.global_position
	blood.global_position = player.global_position
	add_child(death)
	add_child(blood)

func shake_screen(strength,time):
	camera.shake_screen(strength,time)
	
func get_camera() -> Camera2D:
	return camera

func get_world():
	return get_node_or_null("/root/World")
	
		
	
