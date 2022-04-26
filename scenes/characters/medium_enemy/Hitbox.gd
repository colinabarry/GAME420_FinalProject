extends Area2D

onready var parent := get_parent()


func _on_Hitbox_area_entered(area:Area2D):
	if area.is_in_group("light_attack"):
		parent.take_damage(5)
	if area.is_in_group("heavy_attack"):
		parent.take_damage(25)
