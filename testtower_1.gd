extends Area2D

@export var projectile_scene: PackedScene = preload("res://basicbullet.tscn")

var is_placed: bool = false
@onready var range_circle: Sprite2D = $"range circle area/range circle"
@onready var range_area: Area2D = $"range circle area"
@onready var shoot_timer: Timer = $basicbullet/Timer

var current_target: Node2D = null

func set_preview_mode(is_preview: bool) -> void:
	is_placed = !is_preview
	if is_preview:
		modulate.a = 0.5
		monitoring = true
		monitorable = true
		range_circle.show()
	else:
		modulate.a = 1.0
		monitoring = true
		monitorable = true
		range_circle.hide()
		
func set_range_circle_visibility(is_visible: bool):
	if range_circle:
		range_circle.visible = is_visible
		
func set_range_circle_preview(is_preview: bool):
	if range_circle:
		if is_preview:
			range_circle.modulate.a = 0.5
		else:
			range_circle.modulate.a = 1


func is_valid_spot() -> bool:
	var areas = get_overlapping_areas()
	
	for area in areas:
		if area == self or area.get_parent() == self:
			continue
		if area.get_collision_layer_value(3) == true:
			continue
		if area.get_collision_layer_value(2) == true:
			return false
	
	if has_overlapping_bodies():
		return false
	return true

func _ready() -> void:
	range_circle.apply_scale(Vector2(2,2))
	range_circle.modulate.a = 0.5
	
	shoot_timer.timeout.connect(_on_timer_timeout)
	body_entered.connect(_on_enemy_entered)
	body_exited.connect(_on_enemy_exited)
	

func _on_timer_timeout() -> void:
	if is_instance_valid(current_target):
		var bullet = projectile_scene.instantiate() as Area2D
		get_tree().root.add_child(bullet)
		bullet.global_position = self.global_position
		bullet.direction = (current_target.global_position - self.global_position)

func _on_enemy_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") and not current_target:
		current_target = body
		if shoot_timer.is_stopped():
			shoot_timer.start()
	
func _on_enemy_exited(body: Node2D) -> void:
	if body == current_target:
		current_target = null
		shoot_timer.stop()
		find_new_target()

func _process(_delta: float) -> void:
	if is_instance_valid(current_target):
		$Sprite2D.look_at(current_target.global_position)
	else:
		find_new_target()

func find_new_target() -> void:
	var overlapping_bodies = range_area.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("enemies"):
			current_target = body
			if shoot_timer.is_stopped():
				shoot_timer.start()
			return
		current_target = null
		shoot_timer.stop()
		
