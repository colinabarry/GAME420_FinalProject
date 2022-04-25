extends TextureRect


func _ready() -> void:
    material.set_shader_param("uv_curve_x_div", 5)
    material.set_shader_param("uv_curve_y_div", 5)