extends Particles2D




func set_sprite() -> void:
	var sprite = get_parent().get_node("Sprite")
	set_deferred("shader_param/sprite", sprite)

func _on_Obstacle_area_entered(area:Area2D):
	if area.is_in_group("Player"):
		print("explode!")
		emitting = true
