extends Area2D

@export var speed: float
@export var damage: float
@export var piercing: float
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	if direction != Vector2.ZERO:
		look_at(global_position + direction)

func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		global_position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		if body.has_method("takedamage"):
			body.takedamage(damage)
		if piercing > 0:
			piercing -= 1
		else:
			queue_free()
