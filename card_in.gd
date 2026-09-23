extends Node2D

const CARD_SCENE_PATH = "res://card.tscn"
var card_scene = preload(CARD_SCENE_PATH)

var type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func instance_card():
	var new_card = card_scene.instantiate() # instantiate doesn't fully add it
	$"../CardManager".add_child(new_card) # Add here
	transfer_common_variables(new_card)
	return new_card

func transfer_common_variables(card):
	card.type = type
