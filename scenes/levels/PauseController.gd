extends Node

export var can_toggle_pause := true

var time_is_slowing := false
var time_is_resuming := false


func _physics_process(delta) -> void:
	print(Engine.time_scale)
	if time_is_slowing:
		Engine.time_scale = lerp(1.0, 0.0, 0.1)
	if time_is_resuming:
		Engine.time_scale = lerp(0.0, 1.0, 0.1)


func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			resume()
		else:
			pause()


func pause() -> void:
	if can_toggle_pause:
		time_is_slowing = true
		yield(get_tree().create_timer(1), "timeout")
		get_tree().set_deferred("paused", true)
		time_is_slowing = false
		
		
func resume() -> void:
	if can_toggle_pause:
		time_is_resuming = true
		get_tree().set_deferred("paused", false)
		yield(get_tree().create_timer(1), "timeout")
		time_is_resuming = false


func y_timer(yield_time: float) -> void:
	yield(get_tree().create_timer(yield_time), "timeout")
