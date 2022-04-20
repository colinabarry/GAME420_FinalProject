extends Area2D

onready var player = get_parent()
onready var health_bar := get_parent().get_node("HealthBar")


func _on_HurtBox_area_entered(area: Area2D) -> void:
	if area.is_in_group("EnemyAttack"):
		if area.is_in_group("MediumEnemy"):
			player.take_damage(25)
