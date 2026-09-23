class_name MapRoom
extends Area2D

signal selected(room: Room)

const ICONS := {
	Room.Type.NOT_ASSIGNED: [null, Vector2.ONE],
	Room.Type.CAMPFIRE: [preload("res://Art/Fight.png"), Vector2.ONE],
	Room.Type.SHOP: [preload("res://Art/Fight.png"), Vector2.ONE],
	Room.Type.TREASURE: [preload("res://Art/Fight.png"), Vector2.ONE],
	Room.Type.OCCURRENCE: [preload("res://Art/Fight.png"), Vector2.ONE],
	Room.Type.MONSTER: [preload("res://Art/Fight.png")]
}

@onready var sprite_2d: Sprite2D = $Visuals/Sprite2D
@onready var line_2d: Line2D = $Visuals/Line2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var available := false : set = set_available
var room : Room : set = set_room

func set_available(new_value: bool) -> void:
	available = new_value
	
	if available:
		animation_player.play("Fight Icon ")
	elif not room.selected:
		animation_player.play("RESET")
		
		
func set_room(new_data: Room) -> void:
	room = new_data
	position = room.position
	line_2d.rotation_degrees = randi_range(0, 360)
	sprite_2d.texture = ICONS[room.type][0]
	sprite_2d.scale = ICONS[room.type][1]
	
	
func show_selected() -> void:
	line_2d.modulate = Color.WHITE

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not available or not event.is_action_pressed("left_mouse"):
		return
		
	room.selected = true
	animation_player.play("Click")

func on_map_room_selected() -> void:
	selected.emit(room)
	
