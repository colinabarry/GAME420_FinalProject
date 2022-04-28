extends Node2D

var is_attacking = false
var is_attack_pressed: bool = false
var can_heavy_attack: bool = false

onready var timer := $HeavyAttackTimer
onready var attack_animation_player := $AnimationPlayer
onready var weapon := $Pencil


func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position() - Vector2(0, 9))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		remove_from_group("light_attack") if is_in_group("light_attack") else null
		remove_from_group("heavy_attack") if is_in_group("heavy_attack") else null
		attack_animation_player.play("wind_up")
		# weapon.visible = true
		can_heavy_attack = false
		is_attacking = false
		timer.start()
	if event.is_action_released("attack"):
		# weapon.visible = false
		is_attacking = true
		if can_heavy_attack:
			attack_heavy()
		else:
			attack_light()


func attack_light() -> void:
	# print("smol atac")
	add_to_group("light_attack")
	attack_animation_player.play("light_attack")


func attack_heavy() -> void:
	# print("BEEG ATTACK")
	add_to_group("heavy_attack")
	attack_animation_player.play("heavy_attack")


func _on_HeavyAttackTimer_timeout() -> void:
	if not is_attacking:
		attack_animation_player.play("heavy_ready")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "heavy_ready":
		can_heavy_attack = true
