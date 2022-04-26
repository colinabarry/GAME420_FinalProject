class_name LayoutParser
extends Reference

const WALL_VAL := 3


func parse_room_file(file_name: String) -> Array:
	var file := File.new()
	var tile_locations := []

	file.open(file_name, File.READ)

	while file.get_position() < file.get_len():
		var tile_pos_arr = file.get_csv_line(" ")
		var tile_pos := Vector2(tile_pos_arr[0].to_int(), tile_pos_arr[1].to_int())
		tile_locations.append({pos = tile_pos, val = WALL_VAL})

	file.close()
	return tile_locations
