extends StaticBody2D

export var trigger_trap_name : String = ""
export var toggleable : bool = false

onready var sprite = $CollisionShape2D/Sprite as Sprite
onready var area = $Area2D

func _on_Area2D_body_entered(body):
	if body == self: return
	if toggleable:
		sprite.frame = !sprite.frame
		if sprite.frame == 1:
			trigger()
		else:
			untrigger()
	else:
		sprite.frame = 1
		trigger()

func trigger():
	var node = get_node_or_null("/root/World/traps/%s"%trigger_trap_name)
	if node != null and node.has_method("trigger"):
		node.trigger()

func untrigger():
	var node = get_node_or_null("/root/World/traps/%s"%trigger_trap_name)
	if node != null and node.has_method("untrigger"):
		node.untrigger()

func _on_Area2D_body_exited(_body):
	if toggleable: return
	if area.get_overlapping_bodies() == []:
		sprite.frame = 0
		untrigger()
