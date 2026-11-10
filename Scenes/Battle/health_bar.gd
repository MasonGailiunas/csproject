extends ProgressBar

func _ready() -> void:
	var enemy = get_parent()
	if not enemy:
		return
		
	
	if not enemy.is_node_ready():
		await enemy.ready
	
	max_value = enemy.max_health
	value = enemy.health
	
	enemy.health_changed.connect(_on_enemy_health_changed)

func _on_enemy_health_changed(new_health: float) -> void:
	value = new_health
