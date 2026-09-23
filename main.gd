extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_combat()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_combat():
	$PlayerDeck.create_starting_deck()
	$PlayerDeck.create_instanced_deck()
