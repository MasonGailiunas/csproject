extends card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)


func can_play():
	return super.can_play()


func play_card():
	var card_manager_ref = get_parent().get_parent()
	var spell = card_manager_ref.get_placement_manager().finalize_spell_placement(card_manager_ref.get_placement_manager().get_local_grid_pos())
	spell_effects(spell)
	super.play_card()


func spell_effects(spell):
	spell.apply_effect_to_targets()
