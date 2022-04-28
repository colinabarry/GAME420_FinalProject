extends Node2D

const TILE_SIZE := 8
const ROOM_SIZE_TILES := Vector2(32, 18)

export var can_toggle_pause := true

var Player = preload("res://scenes/characters/player/Player.tscn")
var win_menu := load("res://scenes/menus/WinMenu.tscn")
var main_menu := load("res://scenes/menus/main_menu.tscn")
var rooms: Array
var player: KinematicBody2D

onready var tile_map: = get_tree().current_scene.get_node("Navigation2D/TileMap")
onready var enemy_manager := $"/root/EnemyManager"
onready var transition_player := $TransitionPlayer
onready var canvas_modulate := $CanvasModulate


func _ready() -> void:
	randomize()
	generate_level()
	enemy_manager.reload_scene()
	enemy_manager.spawn_enemies()
	transition_player.play("transition")


func generate_level() -> void:
	var dungeon_builder = DungeonBuilder.new(ROOM_SIZE_TILES, 10)
	var map = dungeon_builder.carved_tiles
	rooms = dungeon_builder.rooms
	player = Player.instance()
	add_child(player)
	
	for cell in map:
		tile_map.set_cellv(cell.pos, cell.val)
	
	# var player_start: Vector2 = rooms.front().get_random_position(ROOM_SIZE_TILES, TILE_SIZE)
	var player_start := get_spawn_position(rooms.front())
	player.global_position = player_start
	
	tile_map.update_bitmask_region()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		reload_level()


func reload_level() -> void:
	var _reload_scene = get_tree().reload_current_scene()


func win() -> void:
	get_tree().change_scene_to(win_menu)


func heal_player(enemy_type: String) -> void:
	var amount: int
	if enemy_type == "basic":
		amount = 5
	if enemy_type == "medium":
		amount = 15

	player.heal(amount)


func get_spawn_position(room: DungeonRoom) -> Vector2:
	var spawn_position := room.get_random_position(ROOM_SIZE_TILES, TILE_SIZE)
	var tile_position: Vector2 = tile_map.world_to_map(spawn_position) 
	while tile_map.get_cellv(tile_position) != DungeonBuilder.FLOOR_VAL:
		spawn_position = room.get_random_position(ROOM_SIZE_TILES, TILE_SIZE)
		tile_position = tile_map.world_to_map(spawn_position) 
	
	return spawn_position
