extends Node2D

const CARD_IN_SCENE_PATH = "res://card_in.tscn"
var card_in_scene = preload(CARD_IN_SCENE_PATH)

var trueDeck =[]
var instanceDeck = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_starting_deck():
	for i in range(12):
		var new_card_in = card_in_scene.instantiate() # instantiate doesn't fully add it
		$"..".add_child(new_card_in) # Add here
		trueDeck.insert(0, new_card_in)
		
func create_instanced_deck():
	instanceDeck.clear()
	for i in trueDeck:
		var instance_card = i.instance_card()
		instance_card.hide()
		instanceDeck.insert(0,instance_card)
	instanceDeck.shuffle()

func reshuffle():
	var discard_pile_ref = $"../DiscardPile"
	for i in discard_pile_ref.discard_pile:
		instanceDeck.insert(0, i)
	discard_pile_ref.discard_pile.clear()
	instanceDeck.shuffle()
