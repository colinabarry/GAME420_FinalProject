extends ColorRect

export var new_scene: PackedScene
export var is_quit_button: bool

var anim_time = 0.3
var type: String

onready var light := $Light2D
onready var tween = $Tween
onready var hover_sound := $HoverSound
onready var click_sound := $ClickSound
onready var transition_player := $TransitionPlayer


func _ready() -> void:
	var light_pos = rect_position + rect_size / 2
	light.global_position = light_pos


func _transition(type: String) -> void:
	print("_transition")
	if type == "scene":
		get_tree().change_scene_to(new_scene)
	if type == "quit":
		get_tree().quit()


func _on_MenuButton_gui_input(event:InputEvent):
	if event.is_action_pressed("menu_click"):
		if new_scene:
			type = "scene"
		if not new_scene and is_quit_button:
			type = "quit"
		transition_player.play("transition")
		


func _on_MenuButton_mouse_entered():
	tween.interpolate_property(light, "color:a", light.color.a, 1, anim_time)
	tween.start()
	hover_sound.pitch_scale = 1
	hover_sound.play()


func _on_MenuButton_mouse_exited():
	tween.interpolate_property(light, "color:a", light.color.a, 0, anim_time)
	tween.start()
	hover_sound.pitch_scale = 0.9
	hover_sound.play()


func _on_TransitionPlayer_animation_finished(anim_name:String):
	_transition(type)

