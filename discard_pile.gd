extends Node2D
const COLLISION_MASK = 2
var discard_pile = []
var window_open

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (event.is_pressed()):
			var found = $"../PlayerDeck".raycast_for_target(self)
			if found:
				if !window_open && !$"../PlayerDeck".window_open:
					window_open = true
					open_discard_pile_window()
				else:
					window_open = false
					close_discard_pile_window()
					

func open_discard_pile_window():
	for i in range(discard_pile.size()):
		discard_pile[i].set_interactibility(2)
		$"../PlayerHand".animate_card_to_position(discard_pile[i], $"../PlayerDeck".calculate_card_position(i))
	for i in $"../PlayerHand".hand:
		i.set_interactibility(2)

func close_discard_pile_window():
	for i in range(discard_pile.size()):
		$"../PlayerHand".animate_card_to_position(discard_pile[i], position)
	await get_tree().create_timer(0.1).timeout
	for i in range(discard_pile.size()):
		discard_pile[i].set_interactibility(1)
	for i in $"../PlayerHand".hand:
		i.set_interactibility(0)
