extends Sprite

onready var player = get_parent()
onready var move_anim_player = $MoveAnimationPlayer


func _ready() -> void:
	move_anim_player.play("IdleDown")


func _physics_process(_delta: float) -> void:
	var facing_down := true
	var local_mouse_pos := get_local_mouse_position()
	var player_vel: Vector2 = player.velocity

	flip_h = true if local_mouse_pos.x > 0 else false
	facing_down = true if local_mouse_pos.y > 0 else false

	if player_vel.length() > 25:
		if facing_down:
			move_anim_player.play("WalkDown")
		else:
			move_anim_player.play("WalkUp")
	else:
		if facing_down:
			move_anim_player.play("IdleDown")
		else:
			move_anim_player.play("IdleUp")
