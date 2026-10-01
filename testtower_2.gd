extends Area2D

var is_placed: bool = false
@onready var range_circle: Sprite2D = $"range circle"

func set_preview_mode(is_preview: bool) -> void:
	is_placed = !is_preview
	if is_preview:
		modulate.a = 0.5
		monitoring = true
		range_circle.show()
	else:
		modulate.a = 1.0
		monitoring = false
		range_circle.hide()
		
func set_range_circle_visibility(is_visible: bool):
	if range_circle:
		range_circle.visible = is_visible
		
func set_range_circle_preview(is_preview: bool):
	if range_circle:
		if is_preview:
			range_circle.modulate.a = 0.5
		else:
			range_circle.modulate.a = 1


func is_valid_spot() -> bool:
	return has_overlapping_areas() == false and has_overlapping_bodies() == false

func _ready() -> void:
	range_circle.apply_scale(Vector2(4,4))
	range_circle.modulate.a = 0.5
