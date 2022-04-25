extends Enemy

var arrival_zone_radius: int = 50
var player_in_attack_range: bool = false
var can_attack: bool = true
var attack_interval: int = 5
var attack_target: Vector2
var attack_start: Vector2
var is_attacking: bool = false
var is_alive := true

var max_health := 100
var health = max_health

onready var move_animation_player := $AnimationPlayer
onready var health_bar := $HealthBarContainer/HealthBar
onready var enemy_manager = $"/root/EnemyManager"


func _ready() -> void:
	move_animation_player.play("Move")
	player = get_tree().current_scene.get_node("Player")


func _physics_process(_delta) -> void:
	if is_alive:
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
			elif (position - player.position).length() <= arrival_zone_radius - 5:
				velocity = move_and_slide((position - player.position).normalized() * max_speed * .25)
				if player_in_attack_range:
					attack()
			else:
				orbit()
				if player_in_attack_range:
					attack()
	else:
		velocity = lerp(velocity, Vector2.ZERO, 0.05)


func take_damage(amount: int) -> void:
	if is_alive:
		health -= amount
		if health <= 0:
			_die()
		health_bar.on_health_updated(health, amount)


func _die() -> void:
	is_alive = false
	move_animation_player.play("Die")
	enemy_manager.remove_enemy("medium")


func lunge() -> void:
	print("Attack!")


func attack() -> void:
	if can_attack:
		move_animation_player.play("Wiggle")


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
	if anim_name == "Wiggle":
		move_animation_player.play("Attack")
		can_attack = false
		attack_target = player.global_position
		attack_start = global_position
		is_attacking = true
		$AttackCooldown.start()
	if anim_name == "Attack":
		move_animation_player.play("Move")
