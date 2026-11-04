extends Parallax2D

@export var scroll_speed: float = -100.0 

func _process(delta: float) -> void:
	
	autoscroll.x = scroll_speed
