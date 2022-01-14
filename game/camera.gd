extends Camera2D

var shake_strength : float
var shake_time : float 
var shake_timer : float = 0.0

func shake_screen(amplitude,duration):
	shake_strength = amplitude
	shake_time = duration
	shake_timer = duration

func _physics_process(delta):
	if shake_timer > 0:
		offset.x = lerp(offset.x,rand_range(-shake_strength,shake_strength)*(shake_timer/shake_time),0.7)
		offset.y = lerp(offset.y,rand_range(-shake_strength,shake_strength)*(shake_timer/shake_time),0.7)
		shake_timer = shake_timer-delta if shake_timer-delta > 0 else 0
	
