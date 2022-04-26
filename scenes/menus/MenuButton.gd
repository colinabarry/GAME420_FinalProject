extends ColorRect

export var new_scene: PackedScene
export var is_quit_button: bool

var anim_time = 0.3

onready var light := $Light2D
onready var tween = $Tween


func _ready() -> void:
	var light_pos = rect_position + rect_size / 2
	light.global_position = light_pos


func _on_MenuButton_gui_input(event:InputEvent):
	if event.is_action_pressed("menu_click"):
		if new_scene:
			get_tree().change_scene_to(new_scene)
		if not new_scene and is_quit_button:
			get_tree().quit()


func _on_MenuButton_mouse_entered():
	tween.interpolate_property(light, "color:a", light.color.a, 1, anim_time)
	tween.start()


func _on_MenuButton_mouse_exited():
	tween.interpolate_property(light, "color:a", light.color.a, 0, anim_time)
	tween.start()
