extends Node2D


func _ready():
	var tween = Tools.tween($Laser,"scale",Vector2(1.0,0.2),Vector2(1.0,1.0),1.0,Tween.TRANS_CUBIC,Tween.EASE_IN)
	yield(tween,"tween_all_completed")
	$Laser.modulate.a = 1.0
	$DeathArea.set_deferred("monitoring",true)
	
func player_entered(body):
	body.death()
