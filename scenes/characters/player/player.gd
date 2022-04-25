extends Character

# signal player_damaged(health, amount)

export(float) onready var player_friction: float = 0.15
export(int) onready var player_acceleration: int = 20
export(int) onready var player_max_speed: int = 100
export var health: int = 100

var input_axis: Vector2 = Vector2.ZERO
var frame: int = 0
var is_dashing: bool = false

onready var health_bar := $HealthBar
onready var dash_timer := $DashTimer
onready var hurtbox_collision := $HurtBox

# func _ready() -> void:
# 	update_player_vars()


func _physics_process(_delta: float) -> void:
	get_input()
	# $HealthBar._on_health_updated(health, 0)
	move()


# Gets the x and y input_axis from input events and sets move_direction to the resulting value
# By taking the difference of the "strength" of the events, each axis can be set in a single line
func get_input() -> void:
	input_axis.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_axis.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	move_direction = input_axis


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dash") and not is_dashing:
		dash_timer
		is_dashing = true
		hurtbox_collision.set_deferred("monitoring", false)
		max_speed = 300
		velocity += velocity
		yield(get_tree().create_timer(0.2), "timeout")
		max_speed = 50
		hurtbox_collision.set_deferred("monitoring", true)
		is_dashing = false


func take_damage(amount: int) -> void:
	if health - amount > 0:
		health -= amount
		# emit_signal("player_damaged", health, amount)
		health_bar.on_health_updated(health, amount)
	else:
		_die()


func _die() -> void:
	get_tree().reload_current_scene()
