extends Enemy
var test: bool = true
var can_move: bool = true
var is_alive := true
var health = 40

onready var health_bar = $HealthBarContainer/HealthBar
onready var enemy_manager = $"/root/EnemyManager"


func _ready() -> void:
	$AnimationPlayer.play("walk")


func _physics_process(_delta) -> void:
	if is_alive:
		look_at(player.position)
	#	Check if move timer is done and the enemy can move
		if can_move:
			if $MoveCooldown.time_left == 0:
				$MoveCooldown.start()
			chase()
			sporadic_move()
			can_move = false
	else:
		velocity = lerp(velocity, Vector2.ZERO, 0.05)


func sporadic_move() -> void:
	if test:
		move_direction = move_direction.clamped(1).rotated(deg2rad(25))
		test = false
	else:
		move_direction = move_direction.clamped(1).rotated(deg2rad(-25))
		test = true
	velocity += move_direction * acceleration * 2
	velocity = velocity.clamped(max_speed)


func _take_damage(amount: int) -> void:
	if is_alive:
		health -= amount
		if health <= 0:
			_die()
		health_bar.on_health_updated(health, amount)


func _die() -> void:
	is_alive = false
	$PathTimer.stop()
	$AnimationPlayer.play("die")
	enemy_manager.remove_enemy("basic")


func _on_MoveCooldown_timeout():
	can_move = true
	pass  # Replace with function body.


func _on_AttackDetection_area_entered(area):
	if area.is_in_group("Player"):
		print("Hit")
		velocity += move_direction * acceleration * 2
		velocity = -velocity.clamped(max_speed * 2)
	if area.is_in_group("light_attack"):
		_take_damage(5)
	if area.is_in_group("heavy_attack"):
		_take_damage(25)
