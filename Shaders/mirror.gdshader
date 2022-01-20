shader_type canvas_item;

uniform float ref; 
uniform vec4 color: hint_color;
uniform sampler2D noise;
uniform vec2 dis_scale = vec2(0.408, 0.05);
uniform float intensity = 0.07;
uniform float speed = 0.05;

void fragment() {
	float distortion = texture(noise, UV * dis_scale + TIME * speed).y;
	distortion -= 0.5;
	float uv_width = SCREEN_PIXEL_SIZE.x / TEXTURE_PIXEL_SIZE.x;
	vec2 reflected_screenuv = vec2(SCREEN_UV.x - uv_width * (2.0*UV.x-1.0-ref)/2.0, SCREEN_UV.y - intensity*distortion);
	vec4 reflection = texture(SCREEN_TEXTURE, reflected_screenuv);
	
	COLOR.rgb = mix(reflection.rgb, color.rgb, color.a);
}