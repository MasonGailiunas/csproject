extends Node2D

const CARD_SCENE_PATH = "res://card.tscn"
var card_scene = preload(CARD_SCENE_PATH)
var trueDeck =[]
var instanceDeck = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_starting_deck():
	for i in range(12):
		var new_card = card_scene.instantiate() # instantiate doesn't fully add it
		$"../CardManager".add_child(new_card) # Add here
		trueDeck.insert(0, new_card)
		
func create_instanced_deck():
	instanceDeck.clear()
	for i in trueDeck:
		instanceDeck.insert(0,i)
	instanceDeck.shuffle()

func reshuffle():
	var discard_pile_ref = $"../DiscardPile"
	for i in discard_pile_ref.discard_pile:
		instanceDeck.insert(0, i)
	discard_pile_ref.discard_pile.clear()
	instanceDeck.shuffle()
