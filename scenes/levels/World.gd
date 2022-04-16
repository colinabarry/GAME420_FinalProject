extends Node2D

const TILE_SIZE := 8

var Player = preload("res://scenes/characters/player/Player.tscn")
var rooms: Array

onready var tile_map = get_tree().current_scene.get_node("TileMap")


func _ready() -> void:
	randomize()
	generate_level()


func generate_level() -> void:
	print("Hi")
	var dungeon_builder = DungeonBuilder.new(Vector2(32, 18), 10)
	# var map = dungeon_builder.generate_dungeon_tiles(10)
	var map = dungeon_builder.carved_tiles
	rooms = dungeon_builder.rooms
	var player = Player.instance()

	add_child(player)
	var player_start: Vector2 = rooms.front().top_left_corner * TILE_SIZE
	player_start += Vector2(dungeon_builder.room_size / 2) * TILE_SIZE
	player.global_position = player_start

	for cell in map:
		tile_map.set_cellv(cell.pos, cell.val)

	tile_map.update_bitmask_region()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		reload_level()


func reload_level() -> void:
	var _reload_scene = get_tree().reload_current_scene()
