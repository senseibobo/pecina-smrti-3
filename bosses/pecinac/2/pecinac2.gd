extends Boss

onready var spell_hand = $Pecinac/SpellHand
onready var sprite = $Pecinac


func _init():
	boss_name = "Pećinac"
	boss_id = "pecinac"
	phase = 1

func cast_spell(color : Color):
	spell_hand.visible = true
	spell_hand.modulate = color * Color(25.0,25.0,25.0,1.0)
	sprite.frame = 1

func stop_casting():
	spell_hand.visible = false
	sprite.frame = 0
