extends Node2D

@export var waves: Array[WaveData] = []
@export var path_node: Path2D

@onready var spawn_timer: Timer = $SpawnTimer

var current_wave_index: int = 0
var enemies_spawned_this_wave: int = 0
var active_enemies: int = 0

func _ready() -> void:
	print("!!! SCRIPT IS RUNNING AND ALIVE !!!")
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
	
	print("--- WAVE MANAGER DEBUG ---")
	print("Wave Resource Found: ", current_wave)
	if current_wave:
		print("Wave Name: ", current_wave.wave_name)
		print("Spawn Count: ", current_wave.spawn_count)
		print("Spawn Delay: ", current_wave.spawn_delay)
		print("Enemy Scenes Array Size: ", current_wave.enemy_scenes.size())
	print("--------------------------")
	
	spawn_timer.wait_time = current_wave.spawn_delay
	spawn_timer.start()

func spawn_enemy(enemy_scene: PackedScene) -> void:
	if path_node == null:
		path_node = get_parent().find_child("*Path2D*", true, false) as Path2D
		
		if path_node == null:
			path_node = get_parent().find_child("*SPAWN_LOCATION*", true, false) as Path2D

	if not enemy_scene or not path_node:
		print("--- CRITICAL DEBUG: WHERE IS THE PATH? ---")
		print("Enemy Scene is loaded fine! The track is missing.")
		print("Printing your entire level structure below to find the path:")
		get_tree().current_scene.print_tree_pretty()
		print("------------------------------------------")
		return
		
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.loop = false
	
	path_node.add_child(enemy_instance)
	active_enemies += 1
	
	if enemy_instance.has_signal("tree_exited"):
		enemy_instance.tree_exited.connect(_on_enemy_defeated)

func _on_spawn_timer_timeout() -> void:
	var current_wave = waves[current_wave_index]
	
	var target_count = current_wave.spawn_count if current_wave.spawn_count > 0 else 10
	
	print("Timer ticked! Spawned so far: ", enemies_spawned_this_wave, "/", target_count)
	
	if enemies_spawned_this_wave < target_count:
		spawn_enemy(current_wave.enemy_scenes.pick_random())
		enemies_spawned_this_wave += 1
	else:
		print("All wave enemies spawned. Stopping timer, waiting for clearance.")
		spawn_timer.stop()
const DEFEAT_SOUND = preload("res://SoundStorage/SoundEffects/bluh-output.mp3")
func _on_enemy_defeated() -> void:
	active_enemies -= 1
	print("An enemy died! Remaining active enemies: ", active_enemies)
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = DEFEAT_SOUND
	add_child(audio_player)
	audio_player.play()
	audio_player.finished.connect(func(): audio_player.queue_free())
	
	
	var current_wave = waves[current_wave_index]
	if enemies_spawned_this_wave >= current_wave.spawn_count and active_enemies <= 0:
		print("Wave cleared! Preparing next wave...")
		await get_tree().create_timer(2.0).timeout
		start_wave(current_wave_index + 1)
