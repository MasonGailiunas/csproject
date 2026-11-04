extends card


func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

func can_play():
	if get_parent().get_parent().get_placement_manager().current_preview.is_valid_spot():
		return super.can_play()
	return false

func play_card():
	var card_manager_ref = get_parent().get_parent()
	card_manager_ref.get_placement_manager().finalize_spell_placement(card_manager_ref.get_placement_manager().get_local_grid_pos())
	super.play_card()
