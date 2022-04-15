extends Character

export(float) onready var player_friction: float = 0.15
export(int) onready var player_acceleration: int = 20
export(int) onready var player_max_speed: int = 100

var input_axis: Vector2 = Vector2.ZERO
var frame: int = 0


func _ready() -> void:
	update_player_vars()


func _physics_process(_delta: float) -> void:
	# var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	get_input()
	update_player_vars()
	move()


func get_input() -> void:
	input_axis.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_axis.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	move_direction = input_axis


func update_player_vars() -> void:
	frame += 1
	if frame % 60 == 0:
		friction = player_friction
		acceleration = player_acceleration
		max_speed = player_max_speed
		frame = 0
