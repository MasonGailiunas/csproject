extends Node2D

@export var item_scene: PackedScene
@export var tile_map_layer: TileMapLayer

var current_preview: Area2D = null
var source_id = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_build") and current_preview == null:
		start_placement_mode()
		
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if current_preview and current_preview.is_valid_spot():
			var mouse_pos = get_global_mouse_position()
	
	
			var local_grid_pos = tile_map_layer.local_to_map(tile_map_layer.to_local(mouse_pos))
			var snapped_world_pos = tile_map_layer.to_global(tile_map_layer.map_to_local(local_grid_pos))
	
			var source_id = tile_map_layer.get_cell_source_id(local_grid_pos)
	
			current_preview.global_position = snapped_world_pos
			if source_id == 0:
				finalize_placement()

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
	
	
	var local_grid_pos = tile_map_layer.local_to_map(tile_map_layer.to_local(mouse_pos))
	var snapped_world_pos = tile_map_layer.to_global(tile_map_layer.map_to_local(local_grid_pos))
	
	var source_id = tile_map_layer.get_cell_source_id(local_grid_pos)
	
	current_preview.global_position = snapped_world_pos
	
	if current_preview.is_valid_spot():
		if source_id == 0:
			current_preview.modulate = Color(0.5, 1.0, 0.5, 0.6)
		else:
			current_preview.modulate = Color(1.0, 0.5, 0.5, 0.6)
	else:
		current_preview.modulate = Color(1.0, 0.5, 0.5, 0.6)

func finalize_placement() -> void:
	current_preview.set_preview_mode(false)
	current_preview = null 
	

func cancel_placement() -> void:
	current_preview.queue_free()
	current_preview = null
