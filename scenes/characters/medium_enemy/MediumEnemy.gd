extends Enemy

var arrival_zone_radius: int = 50
var player_in_attack_range: bool = false
var can_attack: bool = true
var attack_interval: int = 5
var attack_target: Vector2
var attack_start: Vector2
var is_attacking: bool = false

onready var move_animation_player := $AnimationPlayer


func _ready() -> void:
	move_animation_player.play("Move")


func _physics_process(_delta) -> void:
	look_at(player.position)

	if $LeftCollisionRaycast.is_colliding() == true:
		rotation_speed = -rotation_speed
	elif $RightCollisionRaycast.is_colliding() == true:
		rotation_speed = -rotation_speed

	if is_attacking:
		if $AttackLength.time_left == 0:
			$AttackLength.start()
		velocity = move_and_slide((attack_target - attack_start).normalized() * max_speed * 3)
	else:
		if (position - player.position).length() > arrival_zone_radius:
			chase()
			move()
		elif (position - player.position).length() <= 49:
			velocity = move_and_slide((position - player.position).normalized() * max_speed * 1)
			if player_in_attack_range:
				attack()
		else:
			orbit()
			if player_in_attack_range:
				attack()


func lunge() -> void:
	print("Attack!")


func attack() -> void:
	if can_attack:
		move_animation_player.play("Attack")
		can_attack = false
		attack_target = player.global_position
		attack_start = global_position
		is_attacking = true
		$AttackCooldown.start()


# Called when the enemy's PlayerDetector detects another Area2D entering it
func _on_PlayerDetector_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_in_attack_range = true


func _on_PlayerDetector_area_exited(area):
	if area.is_in_group("Player"):
		player_in_attack_range = false
	pass  # Replace with function body.


func _on_AttackLength_timeout():
	is_attacking = false
	pass  # Replace with function body.


func _on_AttackCooldown_timeout():
	can_attack = true
	# move_animation_player.play("Move")
	pass  # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Attack":
		move_animation_player.play("Move")
