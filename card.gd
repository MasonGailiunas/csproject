extends Node2D
class_name card

signal hovered
signal hovered_off
var in_return_box

var type
@export var cost = 0
@export var rarity = 0
@export var tower_to_place: Area2D = null
@export var effect_to_place = null
@export var damage = 0
@export var block = 0

var interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("cards")
	get_parent().get_parent().connect_card_signals(self)

func _process(delta: float) -> void:
	if $RichTextLabel.text.contains("{d}"):
		$RichTextLabel.text = $RichTextLabel.text.replace("{d}", str(damage))
	if $RichTextLabel.text.contains("{b}"):
		$RichTextLabel.text = $RichTextLabel.text.replace("{b}", str(block))

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

func can_play():
	return true

func play_card():
	var card_manager_ref = get_parent().get_parent()
	card_manager_ref.get_discard_pile().discard_pile.insert(0, self)
	set_interactibility(false)
	card_manager_ref.get_hand().hand.erase(self)
	get_parent().get_parent().get_hand().update_hand_position()
