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

func is_valid_spot() -> bool:
	return has_overlapping_areas() == false and has_overlapping_bodies() == false

func _ready() -> void:
	range_circle.apply_scale(Vector2(2,2))
	range_circle.modulate.a = 0.5


func _process(delta: float) -> void:
	var is_preview = set_preview_mode
	if is_preview:
		var space = get_world_2d().direct_space_state
		var parameters = PhysicsPointQueryParameters2D.new()
		parameters.position = get_global_mouse_position()
		parameters.collide_with_areas = true
		if space.intersect_point(parameters):
			range_circle.show()
		else:
			range_circle.hide()
