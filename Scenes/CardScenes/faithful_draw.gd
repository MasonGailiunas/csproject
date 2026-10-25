extends card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

func can_play():
	var card_manager_ref = get_parent().get_parent()
	for i in card_manager_ref.get_hand().hand:
		if i.draw_add > 0 && i != self:
			print(str(i))
			return false
	return super.can_play()

func play_card():
	var card_manager_ref = get_parent().get_parent()
	card_manager_ref.get_deck().draw_cards(draw_add)
	super.play_card()
