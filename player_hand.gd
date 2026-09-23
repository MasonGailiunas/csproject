extends Node2D

const CARD_SCENE_PATH = "res://card.tscn"
const CARD_WIDTH = 100
var card_scene = preload(CARD_SCENE_PATH)
var hand = []
var hand_max = 10
var referesh_draw = 6
var center_screen_x
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_screen_x = get_viewport().size.x/2

func referesh_hand():
	if hand.size() != 0:
		for i in hand:
			discard_card(i)
	for i in range(referesh_draw):
		var new_card = $"../PlayerDeck".instance_deck[0]
		$"../PlayerDeck".instance_deck.remove_at(0)
		add_card_to_hand(new_card)
		
func add_card_to_hand(card) -> bool:
	if hand.size() < hand_max:
		hand.insert(0, card)
		update_hand_position()
		return true
	return false
	
	
func update_hand_position():
	for i in range(hand.size()):
		var new_pos = calculate_card_pos(i)
		animate_card_to_position(hand[i], new_pos)

func animate_card_to_position(card, new_pos):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_pos, 0.1)
	
	
func calculate_card_pos(index) -> Vector2:
	var total_width = (hand.size() -1) * CARD_WIDTH
	var x_offset = center_screen_x + index * CARD_WIDTH - total_width/2
	return Vector2(x_offset, get_viewport().size.y-100)

	
func discard_card(card):
	var card_index = hand.bsearch(card)
	hand.remove_at(card_index)
	$"../DiscardPile".discard_pile.insert(0, card)
