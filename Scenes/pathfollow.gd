extends PathFollow2D

var speed = 150
@onready var maintower = $"../../../../MainTower/maintowerhealth"

func _physics_process(delta):
	progress += speed * delta
	if progress_ratio >= 1.0:
		maintower.takedamage(50.0)
		queue_free()
