extends Sprite

onready var player = get_parent()


func _physics_process(delta: float) -> void:
	if get_local_mouse_position().x > 0:
		flip_h = true
	else:
		flip_h = false
