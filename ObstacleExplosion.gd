extends Particles2D

onready var sprite = get_parent().get_node("Sprite")


func _ready() -> void:
    set_deferred("shader_param/sprite", sprite)