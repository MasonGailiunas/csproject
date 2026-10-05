extends Node2D

signal hovered
signal hovered_off

var type
var interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().get_parent().connect_card_signals(self)

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)


func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)

func set_interactibility(set_type: bool):
	if set_type:
		show()
		$Area2D/CollisionShape2D.set_deferred("dissabled", false)
		interactable = true
	else:
		hide()
		$Area2D/CollisionShape2D.set_deferred("dissabled", true)
		interactable = false
