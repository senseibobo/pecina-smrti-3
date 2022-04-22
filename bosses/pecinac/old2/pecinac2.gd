extends Boss

onready var spell_hand = $Pecinac/SpellHand
onready var sprite = $Pecinac

var t : float = 0.0

var shaders = [
	"blur",
	"drunk",
	"flip",
	"glass",
	"warp"
]

func _init():
	boss_name = "Pećinac 2"
	boss_id = "pecinac"
	phase = 2

func _ready():
	for shader in shaders:
		set_shader(shader,false)

func remove_health(delta):
	var old_health = health
	.remove_health(delta)
	if health <= 30 and old_health > 30:
		set_shader("drunk")
	elif health <= 20 and old_health > 20:
		set_shader("glass")
	elif health <= 14 and old_health > 14:
		set_shader("flip")
	elif health <= 7 and old_health > 7:
		set_shader("warp")

func set_shader(shader,toggle = true):
	var mat = $Shaders/Shaders.material
	mat.set_shader_param(shader,toggle)

func cast_spell(color : Color):
	spell_hand.visible = true
	spell_hand.modulate = color * Color(25.0,25.0,25.0,1.0)
	sprite.frame = 1

func death():
	.death()
	for shader in shaders:
		set_shader(shader,false)

func stop_casting():
	spell_hand.visible = false
	sprite.frame = 0
