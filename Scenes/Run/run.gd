class_name Run
extends Node

const CAMPFIRE_SCENE := preload("res://Scenes/Campfire/campfire.tscn")
const SHOP_SCENE := preload("res://Scenes/Shop/shop.tscn")
const TREASURE_SCENE := preload("res://Scenes/Treasure/treasure.tscn")
const REWARD_SCENE := preload("res://Scenes/Rewards/rewards.tscn")

@onready var current_view: Node = $CurrentView
@onready var map: Map = $Map
@onready var campfire_button: Node = %CampfireButton
@onready var map_button: Node = %MapButton
@onready var treasure_button: Node = %TreasureButton
@onready var shop_button: Node = %ShopButton
@onready var battle_button: Node = %BattleButton
@onready var reward_button: Node = %RewardsButton

func _ready() -> void:
	_start_run()

func _start_run() -> void:
	_setup_event_connections()


func _change_view(scene: PackedScene) -> void:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	get_tree().pauesd = false
	var new_view := scene.instantiate()
	current_view.add_child(new_view)

func _setup_event_connections() -> void:
	Events.battle_won.connect(_change_view.bind(BATTLE_REWARD_SCENE))
	Events.battle_reward_exited.connect(_change_view.bind(MAP_SCENE))
	Events.campfire_exited.connect(_change_view.bind())
