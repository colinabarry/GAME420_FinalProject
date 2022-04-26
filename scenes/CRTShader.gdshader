shader_type canvas_item;

uniform float scan_line_count : hint_range(0, 1080) =  200;
uniform float scan_line_mix   : hint_range(0, 1)  = 1.0;
uniform float r_offset: hint_range(0, 16) = 0.0;
uniform float g_offset: hint_range(0, 16) = 1.25;
uniform float b_offset: hint_range(0, 16) = 1.25;

uniform float uv_curve_sub: hint_range(0, 1) = 0.6;
uniform float uv_curve_mult: hint_range(0, 5) = 2.0;

uniform float uv_curve_x_div: hint_range(0, 5) = 5.0;
uniform float uv_curve_x_pow: hint_range(0, 5) = 2.0;
uniform float uv_curve_y_div: hint_range(0, 5) = 5.0;
uniform float uv_curve_y_pow: hint_range(0, 5) = 2.0;

uniform float uv_curve_div: hint_range(0, 5) = 2.35;



vec2 uv_curve(vec2 uv) {
	uv = (uv - uv_curve_sub) * uv_curve_mult;
	
	uv.x *= 1.0 + pow(abs(uv.y) / uv_curve_x_div, uv_curve_x_pow);
	uv.x += 0.2;
	uv.y *= 1.0 + pow(abs(uv.x) / uv_curve_y_div, uv_curve_y_pow);
	uv.y += 0.3;
	
	uv = (uv / uv_curve_div) + 0.5;
	return uv;
}

void fragment() {
	float PI = 3.14;
	
	float r = texture(SCREEN_TEXTURE, uv_curve(SCREEN_UV) + vec2(SCREEN_PIXEL_SIZE.x *  r_offset), 0.0).r;
	float g = texture(SCREEN_TEXTURE, uv_curve(SCREEN_UV) + vec2(SCREEN_PIXEL_SIZE.x *  g_offset), 0.0).g;
	float b = texture(SCREEN_TEXTURE, uv_curve(SCREEN_UV) + vec2(SCREEN_PIXEL_SIZE.x * -b_offset), 0.0).b;
	
	float s = sin(uv_curve(SCREEN_UV).y * scan_line_count * PI * 2.0) * scan_line_mix;
	
	const float s_solo_mult = 0.5;
	const float s_solo_add = 0.5;
	const float s_quantity_mult = 3.0;
	const float s_quantity_add = 0.2;
	
	s = (s * s_solo_mult + s_solo_add) * s_quantity_mult + s_quantity_add;
	
	vec4 scan_line = vec4(vec3(pow(s, 0.25)), 1.0);
	vec4 color = vec4(r, g, b, 1.0);
	
	COLOR = color * scan_line;
	
	
}