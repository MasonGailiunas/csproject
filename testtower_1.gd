extends Area2D

var is_placed: bool = false

func set_preview_mode(is_preview: bool) -> void:
	is_placed = !is_preview
	if is_preview:
		modulate.a = 0.5 # Make semi-transparent for preview
		monitoring = true # Ensure it detects obstacles
	else:
		modulate.a = 1.0 # Solid when placed
		monitoring = false # Stop checking once built

func is_valid_spot() -> bool:
	# Returns true if it is NOT overlapping with other bodies/areas
	return has_overlapping_areas() == false and has_overlapping_bodies() == false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
