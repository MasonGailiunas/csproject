extends Node2D

const CARD_IN_SCENE_PATH = "res://card_in.tscn"
var card_in_scene = preload(CARD_IN_SCENE_PATH)
var true_deck =[]
var instance_deck = []

func _ready() -> void:
	create_starting_deck()
	create_instanced_deck()
	$"../PlayerHand".referesh_hand()

func _process(delta: float) -> void:
	$Sprite2D.rotation += 0.01
	$Sprite2D2.rotation += 0.02
	
func create_starting_deck():
	for i in range(12):
		var new_card_in = card_in_scene.instantiate() # instantiate doesn't fully add it
		$"../CardManager".add_child(new_card_in) # Add here
		new_card_in.type = 1
		if (i < 5):
			new_card_in.type = 2
		if (i > 9):
			new_card_in.type = 3
		if (i == 11):
			new_card_in.type = 4
		true_deck.insert(0, new_card_in)
		
func create_instanced_deck():
	instance_deck.clear()
	for i in true_deck:
		var instance_card = i.instance_card()
		instance_card.set_interactibility(false)
		instance_deck.insert(0,instance_card)
	instance_deck.shuffle()
	set_card_positions_in_deck()

func set_card_positions_in_deck():
	for i in instance_deck:
		i.position = position

func reshuffle():
	var discard_pile_ref = $"../DiscardPile"
	for i in discard_pile_ref.discard_pile:
		instance_deck.insert(0, i)
	discard_pile_ref.discard_pile.clear()
	instance_deck.shuffle()
	set_card_positions_in_deck()

func draw_cards(num: int):
	for i in range(num):
		if instance_deck.size() == 0: 
			if $"../DiscardPile".discard_pile.size() == 0: break
			reshuffle()
		$"../PlayerHand".add_card_to_hand(instance_deck[0])
		instance_deck.remove_at(0)
