extends Node2D
@onready var wave_manager: Node2D = $WaveManager
@onready var path_2d: Path2D = $Path2D

func _ready() -> void:
	wave_manager.path_node = path_2d

func _process(delta: float) -> void:
	pass
