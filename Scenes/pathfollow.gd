extends PathFollow2D

var speed = 150
var tower_health = 100

func _physics_process(delta):
	progress += speed * delta
	if progress_ratio >= 1.0:
		tower_health -= 10 
		print("Tower Health: ", tower_health)
		
		queue_free()
