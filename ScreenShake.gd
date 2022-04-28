extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var amplitude = 0
var priority = 0

onready var camera := get_parent()
onready var dur_timer := $DurationTimer
onready var freq_timer := $FrequencyTimer
onready var tween := $Tween


func start(duration = 0.2, frequency = 15, start_amplitude = 16, start_priority = 0):
	if(start_priority >= priority):
		priority = start_priority
		amplitude = start_amplitude
		
		dur_timer.wait_time = duration
		freq_timer.wait_time = 1 / float(frequency)
		dur_timer.start()
		freq_timer.start()
		
		_new_shake()

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	tween.interpolate_property(camera, "offset", camera.offset, rand, freq_timer.wait_time, TRANS, EASE)
	tween.start()
	
func _reset():
	tween.interpolate_property(camera, "offset", camera.offset, Vector2.ZERO, freq_timer.wait_time, TRANS, EASE)
	tween.start()
	
	priority = 0


func _on_FrequencyTimer_timeout():
	_new_shake()


func _on_DurationTimer_timeout():
	_reset()
	freq_timer.stop()
