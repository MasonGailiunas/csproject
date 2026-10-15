extends Area2D

@export var projectile_scene: PackedScene = preload("res://basicbullet.tscn")

var is_placed: bool = false
@onready var range_circle: Sprite2D = $"range circle area/range circle"
@onready var range_area: Area2D = $"range circle area"
@onready var shoot_timer: Timer = $ShootTimer

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
	range_area.body_entered.connect(_on_enemy_entered)
	range_area.body_exited.connect(_on_enemy_exited)
	

func _on_timer_timeout() -> void:
	print("timer timeout")
	
	if not is_instance_valid(current_target):
		find_new_target()
		
	if is_instance_valid(current_target):
		print("valid")
		var bullet = projectile_scene.instantiate() as Area2D
		
		# FIX: Add the bullet to the tower's parent (the map/level node) 
		# instead of the engine's absolute root window
		get_parent().add_child(bullet)
		
		# Now the coordinates will align perfectly with your map visuals
		bullet.global_position = self.global_position
		
		if "direction" in bullet:
			bullet.direction = (current_target.global_position - self.global_position).normalized()

func _on_enemy_entered(body: Node2D) -> void:
	print("--- ENEMY ENTERED DETECTION ---")
	print("Node Name: ", body.name)
	print("Actual Groups on this node: ", body.get_groups())
	print("Is in 'enemies' group?: ", body.is_in_group("enemies"))
	print("Is current_target already full?: ", current_target != null)
	
	if body.is_in_group("enemies") and not current_target:
		current_target = body
		print("SUCCESS: current_target has been set to: ", current_target.name)
		if shoot_timer.is_stopped():
			shoot_timer.start()
	
func _on_enemy_exited(body: Node2D) -> void:
	print("Exited: ", body.name)
	if body == current_target:
		current_target = null
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
			return # Exit the function immediately because we found a valid target!
	
	# ONLY reset and stop the timer if the loop finished and found zero enemies
	current_target = null
	shoot_timer.stop()





I NEED TO CHANGE THE NODE2D OF THE ENEMY TO CHARACTERBODY2D
	
