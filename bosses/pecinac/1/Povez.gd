extends Sprite


var moving: bool = false

var velocity: Vector2
var gravity: float = 400

func _process(delta: float) -> void:
	if moving:
		velocity.y += gravity*delta
		global_position += velocity*delta
		if global_position.distance_to(Game.get_player_position()) < 100.0:
			Game.get_player().acquire_povez()
			queue_free()
