extends Character

# signal player_damaged(health, amount)

export(float) onready var player_friction: float = 0.15
export(int) onready var player_acceleration: int = 20
export(int) onready var player_max_speed: int = 100
export var health: int = 100

var input_axis: Vector2 = Vector2.ZERO
var frame: int = 0
var is_dashing: bool = false

var lose_menu := load("res://scenes/menus/LoseScreen.tscn")

onready var health_bar := $HealthBar
onready var dash_timer := $DashTimer
onready var hurtbox_collision := $HurtBox
onready var screen_shake := $Camera2D/ScreenShake

# func _ready() -> void:
# 	update_player_vars()


func _physics_process(_delta: float) -> void:
	get_input()
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
		if velocity.length() <= 10:
			var to_mouse = ((get_global_mouse_position() - Vector2(0, 9)) - position)
			velocity = to_mouse.normalized() * 300
		else:
			velocity = velocity.normalized() * 300
		yield(get_tree().create_timer(0.2), "timeout")
		
		max_speed = 50
		hurtbox_collision.set_deferred("monitoring", true)
		is_dashing = false


func take_damage(amount: int) -> void:
	if health - amount > 0:
		var shake_amp = map_range(amount, Vector2(5, 25), Vector2(0.5, 4))
		screen_shake.start(0.2, 12, shake_amp, 5)
		health -= amount
		health_bar.on_health_updated(health, amount)
		# emit_signal("player_damaged", health, amount)
	else:
		_die()


func heal(amount: int) -> void:
	if health < 100:
		health += amount
		health_bar.on_health_updated(health, amount, true)


func _die() -> void:
	$"/root/EnemyManager".reset_enemies()
	get_tree().change_scene_to(lose_menu)


func map_range(range_a_value: float, range_a: Vector2, range_b: Vector2) -> float:
	return range_b.x + (range_a_value - range_a.x)*(range_b.y - range_b.x) / (range_a.y - range_a.x)
