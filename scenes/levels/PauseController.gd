extends Node

export var can_toggle_pause := true

var time_is_slowing := false
var time_is_resuming := false


func _physics_process(delta) -> void:
	print(Engine.time_scale)
	if time_is_slowing:
		Engine.time_scale = lerp(Engine.time_scale, 0.0, 0.2)
	if time_is_resuming:
		Engine.time_scale = lerp(Engine.time_scale, 1.0, 0.2)


func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		if is_equal_approx(Engine.time_scale, 0):
			resume()
		if is_equal_approx(Engine.time_scale, 1):
			pause()


func pause() -> void:
	if can_toggle_pause:
		time_is_slowing = true
		yield(get_tree().create_timer(1.5), "timeout")
		# get_tree().set_deferred("paused", true)
		time_is_slowing = false
		
		
func resume() -> void:
	if can_toggle_pause:
		time_is_resuming = true
		# get_tree().set_deferred("paused", false)
		yield(get_tree().create_timer(2.0), "timeout")
		time_is_resuming = false


func y_timer(yield_time: float) -> void:
	yield(get_tree().create_timer(yield_time), "timeout")
