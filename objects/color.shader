shader_type canvas_item;

uniform vec4 color : hint_color;
uniform float speed:hint_range(0,20);
uniform radius:hint_range(0,1)
uniform with:hint_range(0,1)
void fragment() {
	COLOR.rgb = color.rgb;
	COLOR.a = texture(TEXTURE, UV).a;
}