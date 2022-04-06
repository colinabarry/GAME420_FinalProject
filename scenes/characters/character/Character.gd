extends KinematicBody2D
class_name Character

var friction: float = 0.15
var acceleration: int = 40
var max_speed: int = 100

var move_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, friction)


func move() -> void:
	move_direction = move_direction.normalized()
	velocity += move_direction * acceleration
	velocity = velocity.clamped(max_speed)
	
