extends Node2D

var card_scenes = [preload("res://Scenes/CardScenes/card.tscn"),preload("res://Scenes/CardScenes/strike.tscn"),preload("res://Scenes/CardScenes/defend.tscn"),preload("res://Scenes/CardScenes/balista_card.tscn") ,preload("res://Scenes/CardScenes/draw2.tscn"), preload("res://Scenes/CardScenes/flame_strike.tscn") , preload("res://Scenes/CardScenes/ignite.tscn"), preload("res://Scenes/CardScenes/faithful_draw.tscn")]

var type
var cost
var rarity
var tower_to_place
var effect_to_place

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func instance_card():
	var new_card = card_scenes[type].instantiate() # instantiate doesn't fully add it
	add_child(new_card) # Add here
	transfer_common_variables(new_card)
	return new_card

func transfer_common_variables(card):
	card.type = type
	card.cost = cost
	card.rarity = rarity
	card.effect_to_place = effect_to_place
