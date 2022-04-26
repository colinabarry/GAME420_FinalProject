extends Node2D

const TILE_SIZE := 8
const ROOM_SIZE_TILES := Vector2(32, 18)

export var can_toggle_pause := true

var Player = preload("res://scenes/characters/player/Player.tscn")
var win_menu := load("res://scenes/menus/WinMenu.tscn")
var main_menu := load("res://scenes/menus/main_menu.tscn")
var rooms: Array

onready var tile_map = get_tree().current_scene.get_node("Navigation2D/TileMap")
onready var enemy_manager := $"/root/EnemyManager"


func _ready() -> void:
	randomize()
	generate_level()
	enemy_manager.reload_scene()
	enemy_manager.spawn_enemies()


func generate_level() -> void:
	var dungeon_builder = DungeonBuilder.new(ROOM_SIZE_TILES, 10)
	var map = dungeon_builder.carved_tiles
	rooms = dungeon_builder.rooms
	var player = Player.instance()

	add_child(player)
	var player_start: Vector2 = rooms.front().center * TILE_SIZE
	player.global_position = player_start

	for cell in map:
		tile_map.set_cellv(cell.pos, cell.val)

	tile_map.update_bitmask_region()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		reload_level()


func reload_level() -> void:
	var _reload_scene = get_tree().reload_current_scene()


func win() -> void:
	get_tree().change_scene_to(win_menu)
