extends Boss

onready var spell_hand = $Pecinac/SpellHand
onready var sprite = $Pecinac

var t : float = 0.0

func _init():
	boss_name = "Pećinac 2"
	boss_id = "pecinac"
	phase = 2

func cast_spell(color : Color):
	spell_hand.visible = true
	spell_hand.modulate = color * Color(25.0,25.0,25.0,1.0)
	sprite.frame = 1

func stop_casting():
	spell_hand.visible = false
	sprite.frame = 0
