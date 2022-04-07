class_name Character
extends KinematicBody2D

var move_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

onready var friction: float = 0.15
onready var acceleration: int = 20
onready var max_speed: int = 50


func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	if move_direction == Vector2.ZERO:
		velocity = lerp(velocity, Vector2.ZERO, friction)


func move() -> void:
	move_direction = move_direction.clamped(1)
	velocity += move_direction * acceleration
	velocity = velocity.clamped(max_speed)
