extends Node2D

const COLLISION_MASK_CARD = 1
var card_dragged
var screen_size
var card_hovered

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (event.is_pressed()):
			var card = raycast_for_card()
			if card:
				card_dragged = card
		else:
			card_dragged = null

func raycast_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collide_with_areas = COLLISION_MASK_CARD
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		return find_highest_z_index(result)
	return null

func find_highest_z_index(list):
	var highest = list[0].collider.get_parent()
	for	i in range(1, list.size()):
		var current = list[i].collider.get_parent()
		if current.z_index > highest.z_index:
			highest = current
	return highest
	
func connect_card_signals(card):
		card.connect("hovered", on_hovered)
		card.connect("hovered off", on_hovered_off)

func on_hovered(card):
	if card_hovered == null:
		card_hovered = card
		highlight(card_hovered, true)
func on_hovered_off(card):
	highlight(card, false)
	card_hovered = null
	
func highlight(card, hovered):
	if hovered:
		card.scale = Vector2(1.05, 1.05)
		card.z_index = 2
	else:
		card.scale = Vector2(1,1)
		card.z_index = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if card_dragged:
		var mouse_pos = get_global_mouse_position()
		card_dragged.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x),clamp(mouse_pos.y, 0, screen_size.y) )
