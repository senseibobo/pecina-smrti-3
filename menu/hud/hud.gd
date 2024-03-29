extends CanvasLayer
onready var smrtilabel = get_node("Control/SmrtiLabel")
onready var levellabel = get_node("Control/LevelLabel")
onready var timerlabel = get_node("Control/TimerLabel")

var stopped : bool = false

func _process(delta):
	if stopped: return
	State.state["time"] += delta*int(!stopped)
	var time = State.state["time"]
	var minutes = str(int(time / 60)).pad_zeros(2)
	var seconds = str(int(fmod(time,60))).pad_zeros(2)
	var milliseconds = str(int(fmod(time,1)*1000)).pad_zeros(3)
	timerlabel.set_text("%s:%s.%s"%[minutes,seconds,milliseconds])

func finished():
	$Control/LevelLabel.visible = false
	stopped = true
	$Control/SmrtiLabel.visible = false

func _ready():
	Game.connect("game_finished",self,"finished")
	update_deaths()
	update_level()

func update_deaths():
	if smrtilabel != null:
		smrtilabel.set_text("Smrti: %s"%State.state["deaths"])
		$Control/SmrtiLabel.modulate = Color(1,1,1,1)
		$Tween.interpolate_property($Control/SmrtiLabel,"rect_scale",Vector2(1.2,1.2),Vector2(1,1),0.1)
		$Tween.start()

func update_level():
	if levellabel != null:
		levellabel.set_text("Level: %s"%State.state["current_level"])
