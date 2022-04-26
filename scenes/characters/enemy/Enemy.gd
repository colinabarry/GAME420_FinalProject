class_name Enemy
extends Character

var path: PoolVector2Array

var max_steering: float = 2.5
var rotation_speed: float = .025

onready var navigation: Navigation2D = get_tree().current_scene.get_node("Navigation2D")
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")


func _ready() -> void:
	player = get_tree().current_scene.get_node("Player")


func chase() -> void:
	if path:
		var vector_to_next_point: Vector2 = path[0] - global_position
		var distance_to_next_point: float = vector_to_next_point.length()

		if distance_to_next_point < 1:
			path.remove(0)
			if not path:
				return
		move_direction = vector_to_next_point


func orbit() -> void:
	var point: Vector2 = player.position
	velocity = Vector2.ZERO
	position = point + (position - point).rotated(rotation_speed)


func _on_PathTimer_timeout() -> void:
	path = navigation.get_simple_path(global_position, player.position)
	$PathTimer.start()
