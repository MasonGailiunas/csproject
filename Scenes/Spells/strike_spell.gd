extends spell

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		

func set_preview_mode(is_preview: bool) -> void:
	super.set_preview_mode(is_preview)
				
func set_range_circle_visibility(is_visible: bool) -> void:
	super.set_range_circle_visibility(is_visible)
		

func is_valid_spot() -> bool:
	return super.is_valid_spot()

		
func apply_effect_to_targets():
	for i in target_enenmies:
		i.takedamage(damage)


func _on_range_circle_area_body_entered(body: Node2D) -> void:
	super._on_range_circle_area_body_entered(body)


func _on_range_circle_area_body_exited(body: Node2D) -> void:
	super._on_range_circle_area_body_exited(body)
