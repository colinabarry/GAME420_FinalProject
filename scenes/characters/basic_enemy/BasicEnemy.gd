extends Enemy
var test: bool = true
var can_move: bool = true


func _physics_process(_delta) -> void:
	look_at(player.position)
#	Check if move timer is done and the enemy can move
	if can_move:
		if $MoveCooldown.time_left == 0:
			$MoveCooldown.start()
		chase()
		sporadic_move()
		can_move = false
	pass


func sporadic_move() -> void:
	if test:
		move_direction = move_direction.clamped(1).rotated(deg2rad(25))
		test = false
	else:
		move_direction = move_direction.clamped(1).rotated(deg2rad(-25))
		test = true
	velocity += move_direction * acceleration * 2
	velocity = velocity.clamped(max_speed)


func _on_MoveCooldown_timeout():
	can_move = true
	pass  # Replace with function body.


func _on_AttackDetection_area_entered(area):
	if area.is_in_group("Player"):
		print("Hit")
		velocity += move_direction * acceleration * 2
		velocity = -velocity.clamped(max_speed * 2)
	pass # Replace with function body.
