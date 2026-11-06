extends Node2D


signal health_changed(new_health: float)

@export var max_health: float = 20.0

@onready var health: float = max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("enemies")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func takedamage(damage: float) -> void:
	health -= damage
	
	health_changed.emit(health)
	
	if health <= 0:
		get_parent().queue_free()
