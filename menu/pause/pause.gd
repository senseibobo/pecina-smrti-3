extends CanvasLayer

onready var control = $Control as Control

var level_deaths : int = 0
var deaths_for_skip : int = 5

func _ready():
	Game.connect("player_death",self,"add_death")
	Game.connect("level_passed",self,"reset_deaths")

func reset_deaths():
	level_deaths = 0
	$Control/CenterContainer/VBoxContainer/SkipLevel/Button.visible = false

func add_death():
	level_deaths += 1
	print(level_deaths)
	if level_deaths >= deaths_for_skip and Game.current_level != Game.LEVEL_COUNT:
		$Control/CenterContainer/VBoxContainer/SkipLevel/Button.visible = true
		
func toggle_pause():
	control.visible = !control.visible
	get_tree().paused = !get_tree().paused
	
	
func skip_level():
	toggle_pause()
	Game.pass_level()


func _physics_process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()
		
	


func _on_Button_pressed():
	control.visible = false
	get_tree().paused = false




func back():
	Game.return_to_main_menu()
