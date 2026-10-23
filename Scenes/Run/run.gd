class_name Run
extends Node

const BATTLE_SCENE := preload("res://Scenes/Campfire/campfire.tscn")
const BATTLE_REWARD_SCENE := preload("res://Scenes/Campfire/campfire.tscn")
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
	map.show_map()


func _change_view(scene: PackedScene) -> void:
	_clear_view()
	map.hide_map()
	get_tree().paused = false
	current_view.add_child(scene.instantiate())

func _clear_view() -> void:
	for child in current_view.get_children():
		child.queue_free()


func _show_map() -> void:
	_clear_view()
	get_tree().paused = false
	map.show_map()


# Called when a room's encounter is finished
func _return_to_map() -> void:
	_show_map()
	map.unlock_next_rooms()


func _setup_event_connections() -> void:
	Events.battle_won.connect(_change_view.bind(BATTLE_REWARD_SCENE))
	Events.battle_reward_exited.connect(_return_to_map)
	Events.campfire_exited.connect(_return_to_map)
	Events.map_exited.connect(_on_map_exited)
	Events.rewards_exited.connect(_return_to_map)
	Events.shop_exited.connect(_return_to_map)
	Events.treasure_exited.connect(_return_to_map)
	Events.occurrence_exited.connect(_return_to_map)

	battle_button.pressed.connect(_change_view.bind(BATTLE_SCENE))
	campfire_button.pressed.connect(_change_view.bind(CAMPFIRE_SCENE))
	map_button.pressed.connect(_show_map)
	reward_button.pressed.connect(_change_view.bind(REWARD_SCENE))
	shop_button.pressed.connect(_change_view.bind(SHOP_SCENE))
	occurrence_button.pressed.connect(_change_view.bind(OCCURRENCE_SCENE))
	treasure_button.pressed.connect(_change_view.bind(TREASURE_SCENE))


func _on_map_exited(room: Room) -> void:
	match room.type:
		Room.Type.MONSTER:
			_change_view(BATTLE_SCENE)
		Room.Type.CAMPFIRE:
			_change_view(CAMPFIRE_SCENE)
		Room.Type.SHOP:
			_change_view(SHOP_SCENE)
		Room.Type.OCCURRENCE:
			_change_view(OCCURRENCE_SCENE)
