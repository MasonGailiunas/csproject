#extends Node2D
#
#const  GAME_OVER_SCENE := preload("res://Scenes/Battle/game_over.tscn")
#
#@export var tower_health: float
#@onready var lost: bool = false
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#
#func takedamage(damage: float) -> void:
	#tower_health -= damage
	#print("TOWER HEALTH" + str(tower_health))
	#if tower_health <= 0: 
		#var game_over_instance = GAME_OVER_SCENE.instantiate()
		#get_tree().root.add_child(game_over_instance)
		#get_tree().paused = true
		#lost = true
		#print("YOU LOSE!")

extends Node2D

const GAME_OVER_SCENE := preload("res://Scenes/Battle/game_over.tscn")

@export var tower_health: float
@onready var lost: bool = false

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func takedamage(damage: float) -> void:
	if lost: 
		return
		
	tower_health -= damage
	print("TOWER HEALTH: " + str(tower_health))
	
	if tower_health <= 0:
		lost = true 
		print("YOU LOSE!")
		get_tree().change_scene_to_packed(GAME_OVER_SCENE)
