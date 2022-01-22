extends StaticBody2D


func stepped_on(body):
	$Area2D.disconnect("body_entered",self,"stepped_on")
	yield(Tools.tween(self,"modulate",modulate,modulate*Color(1,1,1,0),0.85),"tween_all_completed")
	queue_free()
