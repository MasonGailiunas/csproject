extends Node2D

@export var waves: Array[WaveData] = []
@export var spawn_location_node: Path2D

@onready var spawn_timer: Timer = $SpawnTimer

var current_wave_index: int = 0
var enemies_spawned_this_wave: int = 0
var active_enemies: int = 0

func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	start_wave(current_wave_index)

func start_wave(index: int) -> void:
	if index >= waves.size():
		print("All waves completed! Victory!")
		return
		
	current_wave_index = index
	enemies_spawned_this_wave = 0
	active_enemies = 0
	
	var current_wave = waves[current_wave_index]
	print("Starting: ", current_wave.wave_name)
	
	spawn_timer.wait_time = current_wave.spawn_delay
	spawn_timer.start()

func spawn_enemy(enemy_scene: PackedScene) -> void:
	if not enemy_scene or not spawn_location_node:
		print("Warning: Missing enemy scene or spawn location node!")
		return
		
	var enemy_instance = enemy_scene.instantiate()
	
	enemy_instance.loop = false
	
	spawn_location_node.add_child(enemy_instance)
	
	active_enemies += 1
	
	if enemy_instance.has_signal("tree_exited"):
		enemy_instance.tree_exited.connect(_on_enemy_defeated)

func _on_spawn_timer_timeout() -> void:
	var current_wave = waves[current_wave_index]
	
	print("Timer ticked! Spawned so far: ", enemies_spawned_this_wave, "/", current_wave.spawn_count)
	
	if enemies_spawned_this_wave < current_wave.spawn_count:
		spawn_enemy(current_wave.enemy_scenes.pick_random())
		enemies_spawned_this_wave += 1
	else:
		print("All wave enemies spawned. Stopping timer, waiting for clearance.")
		spawn_timer.stop()

func _on_enemy_defeated() -> void:
	active_enemies -= 1
	print("An enemy died! Remaining active enemies: ", active_enemies)
	
	var current_wave = waves[current_wave_index]
	if enemies_spawned_this_wave >= current_wave.spawn_count and active_enemies <= 0:
		print("Wave cleared! Preparing next wave...")
		await get_tree().create_timer(2.0).timeout
		start_wave(current_wave_index + 1)
