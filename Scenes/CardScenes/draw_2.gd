extends card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

func play_card():
	var card_manager_ref = get_parent().get_parent()
	card_manager_ref.get_deck().draw_cards(2)
	super.play_card()
