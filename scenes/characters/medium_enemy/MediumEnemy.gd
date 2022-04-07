extends Enemy


func _physics_process(_delta) -> void:
	print((position - player.position).length())
	if (position - player.position).length() > 10:
		chase()
		move()
