extends Control

onready var parent = get_parent()
onready var health_over := $HealthOver
onready var health_under := $HealthUnder
onready var update_tween := $UpdateTween

export(Color) var over_color: Color = Color("47ff00")
export(Color) var under_color: Color = Color("ff0000")


func _ready() -> void:
	health_over.tint_progress = over_color
	health_under.tint_progress = under_color
	# connect("damage_taken", self, "_on_health_updated")


func on_health_updated(health: int, amount: int, increasing: bool = false):
	if not increasing:
		health_over.value = health
		update_tween.interpolate_property(health_under, "value", health + amount, health, 1, Tween.TRANS_SINE, 0.4)
	else:
		health_under.value = health
		update_tween.interpolate_property(health_over, "value", health - amount, health, 1, Tween.TRANS_SINE, 0.4)

	update_tween.start()
