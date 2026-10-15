extends Area2D

@export var speed: float = 400.0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	if direction != Vector2.ZERO:
		look_at(global_position + direction)

func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		global_position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	print("PHYSICS TOUCH DETECTED WITH: ", body.name)
	if body.is_in_group("enemies"):
		if body.has_method("takedamage"):
			body.takedamage(10)
		queue_free()
