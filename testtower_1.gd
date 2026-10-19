extends Area2D

@export var projectile_scene: PackedScene = preload("res://basicbullet.tscn")

var is_placed: bool = false
@onready var range_circle: Sprite2D = $"range circle area/range circle"
@onready var range_area: Area2D = $"range circle area"
@onready var shoot_timer: Timer = $ShootTimer

var current_target: Node2D = null

func _ready() -> void:
	range_circle.apply_scale(Vector2(2,2))
	range_circle.modulate.a = 0.5
	
	if not shoot_timer.timeout.is_connected(_on_timer_timeout):
		shoot_timer.timeout.connect(_on_timer_timeout)

func set_preview_mode(is_preview: bool) -> void:
	is_placed = !is_preview
	if is_preview:
		modulate.a = 0.5
		range_circle.show()
		current_target = null
		shoot_timer.stop()
	else:
		modulate.a = 1.0
		range_circle.hide()
		
		# Sweep for any beefy enemies already sitting here when placed
		var bodies = range_area.get_overlapping_bodies()
		for body in bodies:
			if is_instance_valid(body) and body.is_in_group("enemies") and body.health > 0:
				current_target = body
				shoot_timer.start()
				break
				
func set_range_circle_visibility(is_visible: bool) -> void:
	if range_circle:
		range_circle.visible = is_visible
		
func set_range_circle_preview(is_preview: bool) -> void:
	if range_circle:
		if is_preview:
			range_circle.modulate.a = 0.5
		else:
			range_circle.modulate.a = 1.0

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

func _process(_delta: float) -> void:
	if not is_placed: 
		return
		
	if is_instance_valid(current_target):
		$Sprite2D.look_at(current_target.global_position)
	else:
		# If target died or left, grab a new one
		find_next_target()

func _on_timer_timeout() -> void:
	if not is_placed:
		return
		
	if is_instance_valid(current_target):
		var bullet = projectile_scene.instantiate() as Area2D
		get_parent().add_child(bullet)
		bullet.global_position = self.global_position
		
		if "direction" in bullet:
			bullet.direction = (current_target.global_position - self.global_position).normalized()
	else:
		shoot_timer.stop()

func _on_enemy_entered(body: Node2D) -> void:
	if not is_placed:
		return

	if body.is_in_group("enemies") and not is_instance_valid(current_target):
		current_target = body
		if shoot_timer.is_stopped():
			shoot_timer.start()
	
func _on_enemy_exited(body: Node2D) -> void:
	if not is_placed:
		return
		
	if body == current_target:
		current_target = null
		shoot_timer.stop()
		find_next_target()

func find_next_target() -> void:
	var bodies = range_area.get_overlapping_bodies()
	for b in bodies:
		if is_instance_valid(b) and b.is_in_group("enemies") and b.health > 0:
			current_target = b
			if shoot_timer.is_stopped():
				shoot_timer.start()
			return
