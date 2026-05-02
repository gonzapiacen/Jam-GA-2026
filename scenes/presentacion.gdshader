shader_type canvas_item;

uniform float lightness : hint_range(0.f, 1.f) = 1.f;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = lightness;
}
