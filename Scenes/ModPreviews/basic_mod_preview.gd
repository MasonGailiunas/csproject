extends Area2D
class_name mod_preview

var current_target: Node2D = null
var target_enenmies = []

func _ready() -> void:
	$Anim.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		

func is_valid_spot() -> bool:
	var areas = get_overlapping_areas()
	for area in areas:
		if area.is_in_group("towers"):
			return true
	return false

		
func apply_mod():
	for i in get_overlapping_areas():
		if i.is_in_group("towers"):
			mod_effects(i)
			break
	queue_free()
	
func mod_effects(tower):
	pass

func set_preview_mode(is_preview: bool) -> void:
	pass

func set_range_circle_visibility(is_visible: bool) -> void:
	pass
