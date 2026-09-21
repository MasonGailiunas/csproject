extends Camera2D

@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	pass

func move_to_spot(target_pos: Vector2) -> void:
	camera.global_position = target_pos


func _process(delta: float) -> void:
	pass
