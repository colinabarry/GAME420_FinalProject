extends Node2D

const TILE_SIZE := 8
const ROOM_SIZE_TILES := Vector2(32, 18)

var Player = preload("res://scenes/characters/player/Player.tscn")
var BasicEnemy = preload("res://scenes/characters/basic_enemy/BasicEnemy.tscn")
var MediumEnemy = preload("res://scenes/characters/medium_enemy/MediumEnemy.tscn")
var rooms: Array

onready var tile_map = get_tree().current_scene.get_node("Navigation2D/TileMap")


func _ready() -> void:
	randomize()
	generate_level()


func generate_level() -> void:
	var dungeon_builder = DungeonBuilder.new(ROOM_SIZE_TILES, 10)
	# var map = dungeon_builder.generate_dungeon_tiles(10)
	var map = dungeon_builder.carved_tiles
	rooms = dungeon_builder.rooms
	var player = Player.instance()

	add_child(player)
	var player_start: Vector2 = rooms.front().center * TILE_SIZE
	# var player_start: Vector2 = rooms.front().top_left_corner * TILE_SIZE
	# player_start += Vector2(dungeon_builder.room_size / 2) * TILE_SIZE
	player.global_position = player_start

	spawn_medium_enemy(rooms.front())
	spawn_enemies()

	for cell in map:
		tile_map.set_cellv(cell.pos, cell.val)

	tile_map.update_bitmask_region()


func spawn_enemies() -> void:
	var rooms_cpy = rooms

	rooms_cpy.shuffle()
	var spawn_room = rooms_cpy.front()
	spawn_medium_enemy(spawn_room)

	rooms_cpy.shuffle()
	spawn_room = rooms_cpy.front()
	spawn_medium_enemy(spawn_room)


func spawn_medium_enemy(room: DungeonRoom) -> void:
	var new_medium_enemy = MediumEnemy.instance()
	var spawn_offset = Vector2(
		rand_range(-1, 1) * (ROOM_SIZE_TILES.x / 2), rand_range(-1, 1) * (ROOM_SIZE_TILES.y / 2)
	)
	add_child(new_medium_enemy)
	new_medium_enemy.global_position = (room.center + spawn_offset) * TILE_SIZE


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		reload_level()

	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func reload_level() -> void:
	var _reload_scene = get_tree().reload_current_scene()
