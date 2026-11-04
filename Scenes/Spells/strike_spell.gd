extends Area2D

@export var range_circle: Sprite2D
@export var range_area: Area2D
var current_target: Node2D = null
@export var active_time : Timer
var target_enenmies = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		

func set_preview_mode(is_preview: bool) -> void:
	if is_preview:
		range_circle.show()
		current_target = null
	else:
		range_circle.hide()
		
		# Sweep for any beefy enemies already sitting here when placed
		var bodies = range_area.get_overlapping_bodies()
		for body in bodies:
			if is_instance_valid(body) and body.is_in_group("enemies") and body.health > 0:
				current_target = body
				break
				
func set_range_circle_visibility(is_visible: bool) -> void:
	if is_visible:
		range_circle.show()
	else:
		range_circle.hide()
		

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

func _on_enemy_entered(body: Node2D) -> void:
	#if not is_placed:
		#return

	if body.is_in_group("enemies") and not is_instance_valid(current_target) && active_time.time_left > 0:
		target_enenmies.append(body)
