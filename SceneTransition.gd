extends CanvasModulate

signal transition_finished(type)

var button_type: String

onready var animation_player := $AnimationPlayer


func transition(type: String) -> void:
    button_type = type
    animation_player.play("transition")

func _on_AnimationPlayer_animation_finished(anim_name:String):
    emit_signal("transition_finished", button_type)