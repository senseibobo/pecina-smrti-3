extends CanvasLayer

onready var healthbar = $Healthbar/TextureProgress
var boss

func _ready():
	$Label.text = boss.boss_name


func _process(delta):
	healthbar.value = boss.health / boss.max_health * 100.0
	
