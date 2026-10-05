extends Area2D
@export var speed: float = 400.0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		position += speed * delta * direction

func _on_body_entered(body: Area2D) -> void:
	if body.is_in_group("enemies"):
		body.takedamage(10)
