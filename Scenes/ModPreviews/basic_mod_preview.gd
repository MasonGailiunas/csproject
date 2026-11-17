extends Area2D

var current_target: Node2D = null
@export var active_time : Timer
var damage
var target_enenmies = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		

func is_valid_spot() -> bool:
	var areas = get_overlapping_areas()
	for area in areas:
		if area == self or area.get_parent() == self:
			continue
		if area.get_collision_layer_value(3) == true:
			continue
		if area.get_collision_layer_value(2) == true:
			return false
	if has_overlapping_bodies():
		return false
	return true

		
func apply_mod(current_preview):
	pass
