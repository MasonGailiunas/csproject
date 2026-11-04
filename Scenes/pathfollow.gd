extends PathFollow2D

@export var speed: float
@onready var maintower = $"../../../../MainTower/maintowerhealth"
@export var damage: float

func _physics_process(delta):
	progress += speed * delta
	if progress_ratio >= 1.0:
		maintower.takedamage(damage)
		queue_free()
