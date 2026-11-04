extends Node2D

@export var tower_health = 100.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func takedamage(damage: float) -> void:
	tower_health -= damage
	print("TOWER HEALTH" + str(tower_health))
	if tower_health <= 0:
		queue_free()
		print("YOU LOSE!")
		get_tree().paused = true
