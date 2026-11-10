extends card
class_name basic_tower_card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

func can_play():
	var placement_manager_ref = get_parent().get_parent().get_placement_manager()
	if placement_manager_ref.current_preview.is_valid_spot() && placement_manager_ref.get_source_id(placement_manager_ref.get_local_grid_pos()) == 0 && not placement_manager_ref.occupied_tiles.has(placement_manager_ref.get_local_grid_pos()):
		return super.can_play()
	return false

func play_card():
	var card_manager_ref = get_parent().get_parent()
	card_manager_ref.get_placement_manager().finalize_placement(card_manager_ref.get_placement_manager().get_local_grid_pos())
	super.play_card()
