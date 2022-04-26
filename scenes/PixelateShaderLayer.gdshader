shader_type canvas_item;

uniform float pixelFactor : hint_range(0, 20) = 5;

void fragment() {
	vec2 pixelNumber = vec2(textureSize(SCREEN_TEXTURE, 0)) * pixelFactor;
	vec2 pixelatedUV = round(SCREEN_UV * pixelNumber) / pixelNumber;
	COLOR = texture(SCREEN_TEXTURE, pixelatedUV);
}