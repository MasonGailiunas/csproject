extends Node2D

@export var health: float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("enemies")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func takedamage(damage: float) -> void:
	health -= damage
	print(health)
	if health <= 0:
		queue_free()
