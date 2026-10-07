class_name Run
extends Node

const BATTLE_SCENE := preload("res://Scenes/Campfire/campfire.tscn")
const BATTLE_REWARD_SCENE := preload("res://Scenes/Campfire/campfire.tscn")
const MAP_SCENE := preload("res://map.tscn")
const CAMPFIRE_SCENE := preload("res://Scenes/Campfire/campfire.tscn")
const SHOP_SCENE := preload("res://Scenes/Shop/shop.tscn")
const TREASURE_SCENE := preload("res://Scenes/Treasure/treasure.tscn")
const REWARD_SCENE := preload("res://Scenes/Rewards/rewards.tscn")
const OCCURRENCE_SCENE := preload("res://Scenes/Occurrence/occurrence.tscn")

@onready var current_view: Node = $CurrentView
@onready var map: Map = $Map
@onready var campfire_button: Node = %CampfireButton
@onready var map_button: Node = %MapButton
@onready var treasure_button: Node = %TreasureButton
@onready var shop_button: Node = %ShopButton
@onready var battle_button: Node = %BattleButton
@onready var reward_button: Node = %RewardsButton
@onready var occurrence_button: Node = %OccurrenceButton

func _ready() -> void:
	_start_run()

func _start_run() -> void:
	_setup_event_connections()


func _change_view(scene: PackedScene) -> void:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	get_tree().paused = false
	var new_view := scene.instantiate()
	current_view.add_child(new_view)

func _setup_event_connections() -> void:
	Events.battle_won.connect(_change_view.bind(BATTLE_REWARD_SCENE))
	Events.battle_reward_exited.connect(_change_view.bind(MAP_SCENE))
	Events.campfire_exited.connect(_change_view.bind(MAP_SCENE))
	Events.map_exited.connect(_on_map_exited)
	Events.shop_exited.connect(_change_view.bind(MAP_SCENE))
	Events.treasure_exited.connect(_change_view.bind(MAP_SCENE))
	Events.occurrence_exited.connect(_change_view.bind(MAP_SCENE))

	battle_button.pressed.connect(_change_view.bind(BATTLE_SCENE))
	campfire_button.pressed.connect(_change_view.bind(CAMPFIRE_SCENE))
	map_button.pressed.connect(_change_view.bind(MAP_SCENE))
	reward_button.pressed.connect(_change_view.bind(REWARD_SCENE))
	shop_button.pressed.connect(_change_view.bind(SHOP_SCENE))
	occurrence_button.pressed.connect(_change_view.bind(OCCURRENCE_SCENE))
	treasure_button.pressed.connect(_change_view.bind(TREASURE_SCENE))

func _on_map_exited() -> void:
	print("do later") 
