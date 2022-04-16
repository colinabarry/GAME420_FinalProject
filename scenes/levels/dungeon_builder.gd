class_name DungeonBuilder
extends Node

const SPACING := Vector2(5, 6)
const DIRECTIONS := [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]
const CARDINALS := ["east", "north", "west", "south"]

const WALL_VAL := 3
const BACK_WALL_VAL := 2
const FLOOR_VAL := 1
const HALL_VAL := 4

var room_size := Vector2()
var carved_tiles := []
var rooms := []
var room_layout := []
var current_room := Vector2()


func _init(p_size: Vector2, p_num_rooms: int) -> void:
	self.room_size = p_size
	generate_dungeon_tiles(p_num_rooms)


func generate_dungeon_tiles(p_num_rooms: int) -> Array:
	var walker := RoomWalker.new(Vector2(0, 0))
	room_layout = walker.walk(p_num_rooms)
	walker.queue_free()

	var index := 0
	for room in room_layout:
		current_room = room
		place_room(index)
		index += 1

	find_neighbors()
	connect_rooms()

	return carved_tiles


func place_room(p_index: int):
	var top_left_corner = (current_room - room_size / 2).ceil() * (room_size + SPACING)
	rooms.append(DungeonRoom.new(top_left_corner, current_room, room_size, p_index))

	for y in room_size.y + 3:
		for x in room_size.x + 2:
			var new_tile = (top_left_corner - Vector2(1, 2)) + Vector2(x, y)
			carved_tiles.append({pos = new_tile, val = WALL_VAL})

	for x in room_size.x:
		var new_tile = top_left_corner + Vector2(x, -1)
		carved_tiles.append({pos = new_tile, val = BACK_WALL_VAL})

	for y in room_size.y:
		for x in room_size.x:
			var new_tile = top_left_corner + Vector2(x, y)
			carved_tiles.append({pos = new_tile, val = FLOOR_VAL})


func find_neighbors() -> void:
	for room in rooms:
		var neighboring_positions = array_add_value(DIRECTIONS, room.layout_position)
		for i in 4:
			var neighbor_index = room_layout.find(neighboring_positions[i])
			if neighbor_index >= 0:
				room.neighbors[CARDINALS[i]] = rooms[neighbor_index]


func connect_rooms() -> void:
	var rand := RandomNumberGenerator.new()
	for room in rooms:
		randomize()
		var r_width: int = room.size.x
		var r_height: int = room.size.y
		var h_position: Vector2
		var h_offset_x: int = rand.randi_range(2, r_width - 2)
		var h_offset_y: int = rand.randi_range(3, r_height - 3)

		if room.neighbors["north"] and not room.connected_edges["north"]:
			room.connected_edges["north"] = true
			room.neighbors["north"].connected_edges["south"] = true
			h_position = room.top_left_corner + Vector2(h_offset_x, -1)
			for i in SPACING.y:
				carved_tiles.append({pos = h_position, val = HALL_VAL})
				carved_tiles.append({pos = h_position + Vector2(1, 0), val = HALL_VAL})
				carved_tiles.append({pos = h_position + Vector2(-1, 0), val = WALL_VAL})
				carved_tiles.append({pos = h_position + Vector2(2, 0), val = WALL_VAL})
				h_position += Vector2(0, -1)

		if room.neighbors["south"] and not room.connected_edges["south"]:
			room.connected_edges["south"] = true
			room.neighbors["south"].connected_edges["north"] = true
			h_position = room.top_left_corner + Vector2(h_offset_x, r_height)
			for i in SPACING.y:
				carved_tiles.append({pos = h_position, val = HALL_VAL})
				carved_tiles.append({pos = h_position + Vector2(-1, 0), val = HALL_VAL})
				carved_tiles.append({pos = h_position + Vector2(1, 0), val = WALL_VAL})
				carved_tiles.append({pos = h_position + Vector2(-2, 0), val = WALL_VAL})
				h_position += Vector2(0, 1)

		if room.neighbors["east"] and not room.connected_edges["east"]:
			room.connected_edges["east"] = true
			room.neighbors["east"].connected_edges["west"] = true
			h_position = room.top_left_corner + Vector2(r_width, h_offset_y)
			for i in SPACING.x:
				carved_tiles.append({pos = h_position, val = HALL_VAL})
				carved_tiles.append({pos = h_position + Vector2(0, 1), val = HALL_VAL})
				carved_tiles.append({pos = h_position + Vector2(0, -1), val = WALL_VAL})
				carved_tiles.append({pos = h_position + Vector2(0, 2), val = WALL_VAL})
				h_position += Vector2(1, 0)

		if room.neighbors["west"] and not room.connected_edges["west"]:
			room.connected_edges["west"] = true
			room.neighbors["west"].connected_edges["east"] = true
			h_position = room.top_left_corner + Vector2(-1, h_offset_y)
			for i in SPACING.x:
				carved_tiles.append({pos = h_position, val = HALL_VAL})
				carved_tiles.append({pos = h_position + Vector2(0, -1), val = HALL_VAL})
				carved_tiles.append({pos = h_position + Vector2(0, 1), val = WALL_VAL})
				carved_tiles.append({pos = h_position + Vector2(0, -2), val = WALL_VAL})
				h_position += Vector2(-1, 0)


# Utility function to add all elements of two same-sized arrays
# Returns an array containing the resulting values or an array containing null if different sizes
func array_add_array(arr_a: Array, arr_b: Array) -> Array:
	if arr_a.size() == arr_b.size():
		var arr_c := []
		for i in arr_a.size():
			arr_c[i] = arr_a[i] + arr_b[i]
		return arr_c
	else:
		return [null]


# Utility function to add a value to every element in an array
# Returns an array containing the resulting values
func array_add_value(arr_a: Array, value) -> Array:
	var arr_b := arr_a.duplicate()
	for i in arr_a.size():
		arr_b[i] = arr_a[i] + value
	return arr_b
