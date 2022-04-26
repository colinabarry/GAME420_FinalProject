class_name DungeonRoom
extends Reference

var top_left_corner: Vector2
var center: Vector2
var layout_position: Vector2
var size: Vector2
var index: int
var neighbors := {north = null, south = null, east = null, west = null}
var connected_edges := {north = false, south = false, east = false, west = false}

func _init(p_top_left_corner: Vector2, p_layout_position: Vector2, p_size: Vector2, p_index) -> void:
	self.top_left_corner = p_top_left_corner
	self.layout_position = p_layout_position
	self.size = p_size
	self.index = p_index
	self.center = top_left_corner + (size / 2)


func get_random_position(room_size_tiles: Vector2, tile_size: int) -> Vector2:
	var offset: Vector2
	offset.x = rand_range(-1, 1) * (room_size_tiles.x / 2)
	offset.y = rand_range(-1, 1) * (room_size_tiles.y / 2)
	
	return (self.center + offset) * tile_size