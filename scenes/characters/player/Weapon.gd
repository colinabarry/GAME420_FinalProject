extends Node2D

var is_attack_pressed: bool = false
var can_heavy_attack: bool = false

onready var timer := $HeavyAttackTimer


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		can_heavy_attack = false
		timer.start()
	if event.is_action_released("attack"):
		if can_heavy_attack:
			attack_heavy()
		else:
			attack_light()


func attack_light() -> void:
	print("smol atac")


func attack_heavy() -> void:
	print("BEEG ATTACK")


func _on_HeavyAttackTimer_timeout() -> void:
	can_heavy_attack = true
