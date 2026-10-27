extends Node2D

const COLLISION_MASK = 2
const CARD_IN_SCENE_PATH = "res://card_in.tscn"
var card_in_scene = preload(CARD_IN_SCENE_PATH)
var true_deck =[]
var instance_deck = []
var window_open

func _ready() -> void:
	create_starting_deck()
	create_instanced_deck()
	$"../PlayerHand".referesh_hand()

func _process(delta: float) -> void:
	$Sprite2D.rotation += 0.01
	$Sprite2D2.rotation += 0.02
	
func create_starting_deck():
	for i in range(12):
		var new_card_in = card_in_scene.instantiate() # instantiate doesn't fully add it
		$"../CardManager".add_child(new_card_in) # Add here
		new_card_in.type = 1
		if (i < 5):
			new_card_in.type = 2
		if (i > 9):
			new_card_in.type = 3
		if (i == 11):
			new_card_in.type = 4
		true_deck.insert(0, new_card_in)
		
func create_instanced_deck():
	instance_deck.clear()
	for i in true_deck:
		var instance_card = i.instance_card()
		instance_card.set_interactibility(1)
		instance_deck.insert(0,instance_card)
	instance_deck.shuffle()
	set_card_positions_in_deck()

func set_card_positions_in_deck():
	for i in instance_deck:
		i.position = position

func reshuffle():
	var discard_pile_ref = $"../DiscardPile"
	for i in discard_pile_ref.discard_pile:
		instance_deck.insert(0, i)
	discard_pile_ref.discard_pile.clear()
	instance_deck.shuffle()
	set_card_positions_in_deck()

func draw_cards(num: int):
	for i in range(num):
		if instance_deck.size() == 0: 
			if $"../DiscardPile".discard_pile.size() == 0: break
			reshuffle()
		$"../PlayerHand".add_card_to_hand(instance_deck[0])
		instance_deck.remove_at(0)
		await get_tree().create_timer(0.05).timeout

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (event.is_pressed()):
			var found = raycast_for_target(self)
			if found:
				if !window_open && !$"../DiscardPile".window_open:
					window_open = true
					open_deck_window()
				else: if window_open:
					window_open = false
					close_deck_window()

func raycast_for_target(target):
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collide_with_areas = COLLISION_MASK
	var result = space_state.intersect_point(parameters)
	result = filter_raycast_for_target(result, target)
	if result.size() > 0:
		return true
	return false

func filter_raycast_for_target(list, target):
	var removes = []
	for i in list:
		if i.collider.get_parent() != target:
			removes.insert(0,i)
	for i in removes:
		list.erase(i)
	return list

func open_deck_window():
	for i in range(instance_deck.size()):
		instance_deck[i].set_interactibility(2)
		$"../PlayerHand".animate_card_to_position(instance_deck[i], calculate_card_position(i))
	for i in $"../PlayerHand".hand:
		i.set_interactibility(2)

func close_deck_window():
	for i in range(instance_deck.size()):
		$"../PlayerHand".animate_card_to_position(instance_deck[i], position)
	await get_tree().create_timer(0.1).timeout
	for i in range(instance_deck.size()):
		instance_deck[i].set_interactibility(1)
	for i in $"../PlayerHand".hand:
		i.set_interactibility(0)

func calculate_card_position(index):
	var x = $"../PlayerHand".center_screen_x + (index%10)*150 - 150*4.5
	var y = 250 * (int)(index/10) + 150
	return Vector2(x,y)
