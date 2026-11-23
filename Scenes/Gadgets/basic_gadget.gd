extends Area2D
class_name gadget

@export var is_placed: bool = false
@export var damage : int
@export var active: bool

var mods = []

func _ready() -> void:
	add_to_group("gadgets")

func _process(_delta: float) -> void:
	pass
	
func set_preview_mode(is_preview: bool) -> void:
	pass

func set_range_circle_visibility(is_visible: bool) -> void:
	pass

func is_valid_spot() -> bool:
	var areas = get_overlapping_areas()
	for area in areas:
		if area == self or area.get_parent() == self:
			continue
	if !get_parent().check_valid_source_id([0]):
		return false
	if get_parent().occupied_tiles.has(get_parent().get_local_grid_pos()):
			return false
	if has_overlapping_bodies():
		return false
	return true

func can_activate() -> bool:
	return true

func activate():
	active = true
	on_activate()
	
func on_activate():
	pass
