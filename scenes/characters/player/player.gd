extends Character

export onready var player_friction
export onready var player_acceleration
export onready var player_max_speed

var input_axis: Vector2 = Vector2.ZERO


func _process(_delta: float) -> void:
    var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
    input_axis.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_axis.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    
    
    move_direction = input_axis
    move()