class_name MapGenerator
extends Node

const X_DIST := 50
const Y_DIST := 80
const FLOORS := 9
const MAP_WIDTH := 3
const SHOP_ROOM_WEIGHT := 2.0
const CAMPFIRE_ROOM_WEIGHT := 2.0
const TREASURE_ROOM_WEIGHT := 2.0
const MYSTERY_ROOM_WEIGHT := 2.0

var random_room_type_weights = {
	Room.Type.MONSTER: 0.0,
	Room.Type.CAMPFIRE: 0.0,
	Room.Type.SHOP: 0.0,
	Room.Type.OCCURRENCE: 0.0,
}
var random_room_type_total_weight := 0
var map_data: Array[Array]


func generate_map() -> Array[Array]:
	map_data = generate_initial_grid()


func generate_initial_grid() -> Array[Array]:
	var result: Array[Array] = []
	for i in FLOORS:
		var adjacent_rooms: Array[Room] =  []
		
		for j in MAP_WIDTH:
			var current_room := Room.new()
			current_room.position = Vector2(j * X_DIST, i * Y_DIST)
			current_room.row = i
			current_room.column = j
			current_room.next_rooms = []
			
			if i == FLOORS -1:
				current_room.position.y = (i+1) * Y_DIST
				
			adjacent_rooms.append(current_room)
			
		result.append(adjacent_rooms)
		
	return result
