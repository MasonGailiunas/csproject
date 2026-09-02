extends Node2D

@export var item_scene: PackedScene
@onready var tile_map_layer: TileMapLayer = $TileMapLayer

var current_preview: Area2D = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_build") and current_preview == null:
		start_placement_mode()
		
	# 2. Confirm placement on Left Mouse Click
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if current_preview and current_preview.is_valid_spot():
			finalize_placement()

	# 3. Cancel placement on Right Mouse Click
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if current_preview:
			cancel_placement()

func _process(_delta: float) -> void:
	if current_preview:
		update_preview_position()

func start_placement_mode() -> void:
	current_preview = item_scene.instantiate()
	add_child(current_preview)
	current_preview.set_preview_mode(true)

func update_preview_position() -> void:
	var mouse_pos = get_global_mouse_position()
	
	# Convert global mouse position to grid coordinates, then back to local map position
	var local_grid_pos = tile_map_layer.local_to_map(tile_map_layer.to_local(mouse_pos))
	var snapped_world_pos = tile_map_layer.to_global(tile_map_layer.map_to_local(local_grid_pos))
	
	current_preview.global_position = snapped_world_pos
	
	# Optional visual feedback: red if blocked, green if clear
	if current_preview.is_valid_spot():
		current_preview.modulate = Color(0.5, 1.0, 0.5, 0.6) # Green tint
	else:
		current_preview.modulate = Color(1.0, 0.5, 0.5, 0.6) # Red tint

func finalize_placement() -> void:
	current_preview.set_preview_mode(false)
	# Disconnect from preview tracking so it stays in the world
	current_preview = null 
	
	# Automatically restart placement mode if you want to place multiple items
	start_placement_mode() 

func cancel_placement() -> void:
	current_preview.queue_free()
	current_preview = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(tile_map_layer)
