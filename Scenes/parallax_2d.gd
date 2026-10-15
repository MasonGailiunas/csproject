extends Parallax2D

@export var scroll_speed: float = -100.0 

func _process(delta: float) -> void:
	# Progressively add to the built-in autoscroll Vector
	autoscroll.x = scroll_speed
# Called when the node enters the scene tree for the first time.
