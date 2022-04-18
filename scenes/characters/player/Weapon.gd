extends Node2D

var is_attack_pressed: bool = false
var can_heavy_attack: bool = false

onready var timer := $HeavyAttackTimer
onready var attack_animation_player := $AnimationPlayer
onready var weapon := $ColorRect


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		attack_animation_player.play("wind_up")
		weapon.visible = true
		can_heavy_attack = false
		timer.start()
	if event.is_action_released("attack"):
		weapon.visible = false
		if can_heavy_attack:
			attack_heavy()
		else:
			attack_light()


func attack_light() -> void:
	print("smol atac")
	attack_animation_player.play("light_attack")


func attack_heavy() -> void:
	print("BEEG ATTACK")
	attack_animation_player.play("heavy_attack")


func _on_HeavyAttackTimer_timeout() -> void:
	can_heavy_attack = true
