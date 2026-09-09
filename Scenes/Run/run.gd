class_name Run
extends Node

const CAMPFIRE_SCENE := preload("res://Scenes/Campfire/campfire.tscn")
const MAP_SCENE := preload("res://Scenes/Map/map.tscn")
const SHOP_SCENE := preload("res://Scenes/Shop/shop.tscn")
const TREASURE_SCENE := preload("res://Scenes/Treasure/treasure.tscn")
const REWARD_SCENE := preload("res://Scenes/Rewards/rewards.tscn")

@onready var current_view: Node = $CurrentView
@onready var campfire_button: Node = %CampfireButton
@onready var map_button: Node = %MapButton
@onready var treasure_button: Node = %TreasureButton
@onready var shop_button: Node = %ShopButton
@onready var battle_button: Node = %BattleButton
@onready var reward_button: Node = %RewardsButton

var character: CharacterStats

func _ready() -> void:
	if not character:
