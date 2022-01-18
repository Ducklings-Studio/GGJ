shader_type canvas_item; 
render_mode blend_mix, unshaded;

void fragment() {
    vec2 uv = SCREEN_UV;
    vec3 col = texture(SCREEN_TEXTURE, uv).xyz;
	float gs = (col.r * 0.2126 + col.g * 0.7152 + col.b * 0.0722);
    COLOR.rgb = vec3(gs,gs,gs);
}