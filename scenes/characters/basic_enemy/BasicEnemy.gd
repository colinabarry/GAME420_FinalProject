extends Enemy
var test: bool = true
var can_move: bool = true

func _physics_process(_delta) -> void:
	look_at(player.position)
#	Check if move timer is done and the enemy can move
	if can_move:
		if $MoveCooldown.time_left == 0:
			$MoveCooldown.start()
#	Get the player location vector
		var target_location: Vector2 = player.global_position
#	Rotate the vector 45 degrees to the left or right, alternating
		if test:
			target_location = target_location.rotated(deg2rad(30))
			test = false
		else:
			target_location = target_location.rotated(deg2rad(-30))
			test = true
#	move to the new spot
		$RayCast2D.set_cast_to((target_location-global_position).normalized())
		move_and_slide((target_location-global_position).normalized() * max_speed * 5)
		can_move = false
#	chase()
#	move()
	pass


func _on_MoveCooldown_timeout():
	can_move = true
	pass # Replace with function body.
