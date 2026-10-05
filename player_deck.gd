extends Node2D

const CARD_IN_SCENE_PATH = "res://card_in.tscn"
var card_in_scene = preload(CARD_IN_SCENE_PATH)

var true_deck =[]
var instance_deck = []

func _ready() -> void:
	create_starting_deck()
	create_instanced_deck()
	$"../PlayerHand".referesh_hand()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_starting_deck():
	for i in range(12):
		var new_card_in = card_in_scene.instantiate() # instantiate doesn't fully add it
		$"../CardManager".add_child(new_card_in) # Add here
		true_deck.insert(0, new_card_in)
		
func create_instanced_deck():
	instance_deck.clear()
	for i in true_deck:
		var instance_card = i.instance_card()
		instance_card.set_interactibility(false)
		instance_deck.insert(0,instance_card)
	instance_deck.shuffle()

func reshuffle():
	var discard_pile_ref = $"../DiscardPile"
	for i in discard_pile_ref.discard_pile:
		instance_deck.insert(0, i)
	discard_pile_ref.discard_pile.clear()
	instance_deck.shuffle()
