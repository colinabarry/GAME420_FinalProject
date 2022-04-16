extends Character

export(float) onready var player_friction: float = 0.15
export(int) onready var player_acceleration: int = 20
export(int) onready var player_max_speed: int = 100

var input_axis: Vector2 = Vector2.ZERO
var frame: int = 0

# func _ready() -> void:
# 	update_player_vars()


func _physics_process(_delta: float) -> void:
	get_input()
	# update_player_vars()
	move()

	# print(move_direction)


# Gets the x and y input_axis from input events and sets move_direction to the resulting value
# By taking the difference of the "strength" of the events, each axis can be set in a single line
func get_input() -> void:
	input_axis.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_axis.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	move_direction = input_axis

<<<<<<< Updated upstream

# Debug function to update player variables that are editable on the Player node
func update_player_vars() -> void:
	frame += 1
	if frame % 60 == 0:
		friction = player_friction
		acceleration = player_acceleration
		max_speed = player_max_speed
		frame = 0
=======
# func update_player_vars() -> void:
# 	frame += 1
# 	if frame % 60 == 0:
# 		friction = player_friction
# 		acceleration = player_acceleration
# 		max_speed = player_max_speed
# 		frame = 0
>>>>>>> Stashed changes
