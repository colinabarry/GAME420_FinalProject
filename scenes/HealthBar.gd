extends Control

onready var health_over = $HealthOver
onready var health_under = $HealthUnder
onready var update_tween = $UpdateTween

func _on_health_updated(health, amount):
	health_over.value = health
	update_tween.interpolate_property(health_under, "value", health_over.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	update_tween.start()
