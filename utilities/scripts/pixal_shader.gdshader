shader_type canvas_item;

uniform float pixelate : hint_range(64, 1024, 4) = 448;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec2 uv = floor(UV * pixelate) / pixelate;
	COLOR = textureLod(SCREEN_TEXTURE, uv, 0.0);
}
