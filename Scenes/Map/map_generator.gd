#class_name MapGenerator
#extends Node
#
#const X_DIST := 50
#const Y_DIST := 80
#const MAP_WIDTH := 3
#const SEGMENTS := 3
#const SHOP_ROOM_WEIGHT := 2.0
#const CAMPFIRE_ROOM_WEIGHT := 2.0
#const TREASURE_ROOM_WEIGHT := 2.0
#const MYSTERY_ROOM_WEIGHT := 2.0
#
#var random_room_type_weights = {
	#Room.Type.CAMPFIRE: 0.0,
	#Room.Type.SHOP: 0.0,
	#Room.Type.OCCURRENCE: 0.0,
#}
#var random_room_type_total_weight := 0
#var map_data: Array[Array]
#
#func _ready() -> void:
	#generate_map()
#
#func generate_map() -> Array[Array]:
	#
	#map_data = []
	#var current_row := 0
	#
	#for segment in SEGMENTS:
		#map_data.append()
#func _make_room(row: int, column: int, type: Room.Type) -> Room:
	#var room := Room.new()
	#room.row = row
	#room.column = column
	#room.type = type
	#room.next_rooms = []
	#room.position = Vector2(column * X_DIST, row * Y_DIST)
	#return room
#
#func generate_initial_grid() -> Array[Array]:
	#var result: Array[Array] = []
	#for i in FLOORS:
		#var adjacent_rooms: Array[Room] =  []
		#
		#for j in MAP_WIDTH:
			#var current_room := Room.new()
			#current_room.position = Vector2(j * X_DIST, i * Y_DIST)
			#current_room.row = i
			#current_room.column = j
			#current_room.next_rooms = []
			#
			#if i == FLOORS -1:
				#current_room.position.y = (i+1) * Y_DIST
				#
			#adjacent_rooms.append(current_room)
			#
		#result.append(adjacent_rooms)
		#
	#return result
#
#func _get_random_starting_points() -> Array[int]:
	#var y_coordinates: Array[int]
	#for i in 3:
		#var starting_point := 2
		#y_coordinates.append(starting_point)
	#y_coordinates[1] += 2
	#return y_coordinates

class_name MapGenerator
extends Node

const X_DIST := 50
const Y_DIST := 80
const MAP_WIDTH := 3
const BRANCH_ROWS := 2
const SEGMENTS := 4

var non_combat_type_weights = {
	Room.Type.CAMPFIRE: 2.0,
	Room.Type.SHOP: 2.0,
	Room.Type.OCCURRENCE: 2.0,
}

var map_data: Array[Array] = []

func _ready() -> void:
	generate_map()

func generate_map() -> Array[Array]:
	map_data = []
	var current_row := 0

	for segment in SEGMENTS:
		# battle room for this segment
		map_data.append([_make_room(current_row, 1, Room.Type.MONSTER)])
		current_row += 1

		# branch rows: 3-wide, non-combat
		for i in BRANCH_ROWS:
			var row: Array[Room] = []
			for j in MAP_WIDTH:
				row.append(_make_room(current_row, j, _get_random_non_combat_type()))
			map_data.append(row)
			current_row += 1

	# final battle room the last branch funnels into
	map_data.append([_make_room(current_row, 1, Room.Type.MONSTER)])

	_connect_all_segments()
	return map_data

func _make_room(row: int, column: int, type: Room.Type) -> Room:
	var room := Room.new()
	room.row = row
	room.column = column
	room.type = type
	room.next_rooms = []
	room.position = Vector2(column * X_DIST, row * Y_DIST)
	return room

func _connect_all_segments() -> void:
	var row_index := 0
	while row_index < map_data.size() - 1:
		var current: Array[Room] = map_data[row_index]
		var next: Array[Room] = map_data[row_index + 1]

		if current.size() == 1:
			for room in next:
				current[0].next_rooms.append(room)
		elif next.size() == 1:
			for room in current:
				room.next_rooms.append(next[0])
		else:
			for j in MAP_WIDTH:
				current[j].next_rooms.append(next[j])

		row_index += 1

func _get_random_non_combat_type() -> Room.Type:
	var total_weight := 0.0
	for weight in non_combat_type_weights.values():
		total_weight += weight

	var roll := randf() * total_weight
	var cumulative := 0.0
	for type in non_combat_type_weights:
		cumulative += non_combat_type_weights[type]
		if roll <= cumulative:
			return type

	return non_combat_type_weights.keys()[0]
