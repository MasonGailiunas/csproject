extends Node2D

const CARD_SCENE_PATH = "res://card.tscn"
var card_scene = preload(CARD_SCENE_PATH)
var player_hand = []
var discard_pile = []
var hand_max = 10
var referesh_draw = 6
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func referesh_hand():
	for i in player_hand:
		discard_card(i)
	for i in range(referesh_draw):
		var new_card = card_scene.instantiate() # instantiate doesn't fully add it
		$"../CardManager".add_child(new_card) # Add here
		add_card_to_hand(new_card)
func add_card_to_hand(card) -> bool:
	if player_hand.size() < hand_max:
		player_hand.insert(0, card)
		return true
	return false

func discard_card(card):
	var card_index = player_hand.bsearch(card)
	player_hand.remove_at(card_index)
	discard_pile.insert(0, card)
