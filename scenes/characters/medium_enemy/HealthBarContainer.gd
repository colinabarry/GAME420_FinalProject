extends Node2D


func _physics_process(delta) -> void: 
	rotation = -get_parent().rotation
