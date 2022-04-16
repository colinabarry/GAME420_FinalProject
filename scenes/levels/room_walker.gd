class_name RoomWalker
extends Node

const DIRECTIONS := [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]
const TILE_SIZE := 8
const TURN_CHANCE := 0.75

var position := Vector2.ZERO
var direction := Vector2.RIGHT
var rooms := []


func _init(p_starting_position: Vector2) -> void:
	position = p_starting_position


func walk(p_steps: int) -> Array:
	var index := 0
	while index < p_steps:
		if step():
			rooms.append(position)
			index += 1
			if randf() <= TURN_CHANCE:
				change_direction()
		else:
			var rooms_temp := rooms.duplicate()
			rooms_temp.shuffle()
			position = rooms_temp.pop_front()
	return rooms


func step() -> bool:
	var target_position := position + direction
	if not target_position in rooms:
		position = target_position
		return true
	return false


func change_direction() -> void:
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
