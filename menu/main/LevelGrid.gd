extends GridContainer


func _ready():
	for i in range(1,Game.LEVEL_COUNT+1):
		var button = Button.new()
		button.rect_min_size = Vector2(96,96)
		button.connect("pressed",self,"start",[i])
		button.text = str(i)
		if i in [10,20]:
			button.modulate = Color(1.5,1.5,1.5,1.0)
		add_child(button)

func start(level):
	State.state["current_level"] = level
	Game.start_game()
