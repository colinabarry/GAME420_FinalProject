extends Node


var BasicEnemy = preload("res://scenes/characters/basic_enemy/BasicEnemy.tscn")
var MediumEnemy = preload("res://scenes/characters/medium_enemy/MediumEnemy.tscn")

var enemies := {tiny = 0, basic = 0, medium = 0}

onready var world := get_tree().current_scene


func reload_scene() -> void:
	world = get_tree().current_scene
	reset_enemies()


func spawn_enemies() -> void:
	var rooms_cpy = world.rooms

	rooms_cpy.shuffle()
	var spawn_room = rooms_cpy.pop_front()
	spawn_medium_enemy(spawn_room)
	spawn_room = rooms_cpy.pop_front()
	spawn_medium_enemy(spawn_room)
	spawn_room = rooms_cpy.pop_front()
	spawn_medium_enemy(spawn_room)
	spawn_room = rooms_cpy.pop_front()
	spawn_medium_enemy(spawn_room)


func spawn_medium_enemy(room: DungeonRoom) -> void:
	var new_medium_enemy = MediumEnemy.instance()
	var spawn_offset = Vector2(
		rand_range(-1, 1) * (world.ROOM_SIZE_TILES.x / 2), rand_range(-1, 1) * (world.ROOM_SIZE_TILES.y / 2)
	)
	add_child(new_medium_enemy)
	new_medium_enemy.global_position = (room.center + spawn_offset) * world.TILE_SIZE
	enemies.medium += 1
	print("medium: ", enemies.medium)


func remove_enemy(type: String) -> bool:
	if enemies[type] > 0:
		enemies[type] -= 1
		print(type, ": ", enemies[type])
		return true
	else:
		world.win()
		return false


func reset_enemies() -> void:
	enemies = {tiny = 0, basic = 0, medium = 0}
	for child in get_children():
		child.queue_free()
