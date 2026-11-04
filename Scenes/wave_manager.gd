extends Node2D

@export var waves: Array[WaveData] = []
@export var path_node: Path2D

@onready var spawn_timer: Timer = $SpawnTimer

var current_wave_index: int = 0
var active_enemies: int = 0

var enemy_spawn_queue: Array[PackedScene] = []

func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	start_wave(current_wave_index)

func start_wave(index: int) -> void:
	if index >= waves.size():
		print("All waves completed! Victory!")
		return
		
	current_wave_index = index
	active_enemies = 0
	enemy_spawn_queue.clear()
	
	var current_wave = waves[current_wave_index]
	
	for spawn_info in current_wave.enemy_compositions:
		if spawn_info.enemy_scene and spawn_info.count > 0:
			for i in range(spawn_info.count):
				enemy_spawn_queue.append(spawn_info.enemy_scene)
	
	enemy_spawn_queue.shuffle()
	
	spawn_timer.wait_time = current_wave.spawn_delay
	spawn_timer.start()

func spawn_enemy(enemy_scene: PackedScene) -> void:
	if path_node == null:
		path_node = get_parent().find_child("*Path2D*", true, false) as Path2D
		if path_node == null:
			path_node = get_parent().find_child("*SPAWN_LOCATION*", true, false) as Path2D

	if not enemy_scene or not path_node:
		return
		
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.loop = false
	
	path_node.add_child(enemy_instance)
	active_enemies += 1
	
	if enemy_instance.has_signal("tree_exited"):
		enemy_instance.tree_exited.connect(_on_enemy_defeated)

func _on_spawn_timer_timeout() -> void:
	if not enemy_spawn_queue.is_empty():
		var next_enemy = enemy_spawn_queue.pop_front()
		spawn_enemy(next_enemy)
	else:
		spawn_timer.stop()

func _on_enemy_defeated() -> void:
	active_enemies -= 1
	AudioManager.play("EnemyDeath")
	
	if enemy_spawn_queue.is_empty() and active_enemies <= 0:
		await get_tree().create_timer(2.0).timeout 
		start_wave(current_wave_index + 1)
