extends StaticBody2D

export var disappearing : bool = false

onready var sprite = $CollisionShape2D/Sprite as Sprite

func _ready():
	set_appeared(disappearing)

func trigger():
	set_appeared(!disappearing)

func untrigger():
	set_appeared(disappearing)
	
func set_appeared(appeared):
	for child in get_children():
		if child is CollisionShape2D:
			child.call_deferred("set_disabled",!appeared)
			for c in child.get_children():
				c.visible = appeared
