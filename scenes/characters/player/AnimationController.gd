extends Node2D

onready var player = get_parent()
onready var move_animation_player = $MoveAnimationPlayer


func _ready() -> void:
	move_animation_player.play("IdleDown")


func _physics_process(delta: float) -> void:
	if player.velocity.length() > 0.1:
		if player.velocity.y > 0:
			move_animation_player.play("WalkDown")
		if player.velocity.y < 0:
			move_animation_player.play("WalkUp")
	else:
		move_animation_player.play("IdleDown")
