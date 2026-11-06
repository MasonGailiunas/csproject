extends Area2D

@export var range_circle: Sprite2D
@export var range_area: Area2D
var current_target: Node2D = null
@export var active_time : Timer
var damage = 8
var target_enenmies = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	range_circle.apply_scale(Vector2(2,2))
	range_circle.modulate.a = 0.5


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

		
func apply_effect_to_targets():
	for i in target_enenmies:
		i.takedamage(damage)


func _on_range_circle_area_body_entered(body: Node2D) -> void:
	print(str(active_time.time_left))
	if body.is_in_group("enemies") && active_time.time_left > 0:
		target_enenmies.append(body)


func _on_range_circle_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemies") && active_time.time_left > 0:
		target_enenmies.erase(body)
