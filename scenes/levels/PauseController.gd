extends Node

export var can_toggle_pause := true

var time_is_slowing := false
var time_is_resuming := false


func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			resume()
		else:
			pause()


func pause() -> void:
	if can_toggle_pause:
		get_tree().set_deferred("paused", true)
		
		
func resume() -> void:
	if can_toggle_pause:
		get_tree().set_deferred("paused", false)
		