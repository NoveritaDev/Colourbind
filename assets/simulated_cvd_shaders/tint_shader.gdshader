shader_type canvas_item;

uniform vec3 tint = vec3(1.0, 1.0, 1.0);
uniform sampler2D overlay: repeat_disable, filter_nearest, hint_default_transparent;
uniform vec3 overlay_tint = vec3(1.0, 1.0, 1.0);
uniform float glint_intensity = 0.0f;

const float glint_width = 0.8;
const float glint_speed = 2.0f;
const float glint_pause = 1.0;

vec3 srgb_to_linear(vec3 c) {
    return mix(
        c / 12.92,
        pow((c + 0.055) / 1.055, vec3(2.4)),
        step(vec3(0.04045), c)
    );
}

vec3 linear_to_xyz(vec3 c) {
	mat3 to_xyz = transpose(mat3(
        vec3(0.4124565, 0.3575761, 0.1804375),
        vec3(0.2126729, 0.7151522, 0.0721750),
        vec3(0.0193339, 0.1191920, 0.9503041)
    ));
	return to_xyz * c;
}

vec3 xyz_to_lms(vec3 c) {
	mat3 to_lms = transpose(mat3(
        vec3(0.4002, 0.7076, -0.0808),
        vec3(-0.2263, 1.1653, 0.0457),
        vec3(0, 0, 1)
    ));
	
	return to_lms * c;
}

vec3 lms_to_xyz(vec3 c) {
	mat3 to_xyz = transpose(mat3(
		vec3(1.8600666, -1.1294801, 0.2198983),
		vec3(0.3612229, 0.6388043, 0),
		vec3(0, 0, 1.089087)
	));
	return to_xyz * c;
}

vec3 xyz_to_linear(vec3 c) {
	mat3 to_linear = transpose(mat3(
		vec3(3.24045484, -1.5371389, -0.49853155),
		vec3(-0.96926639, 1.8760109, 0.04155608),
		vec3(0.05564342, -0.2040259, 1.05722516)
	));
	return to_linear * c;
}

vec3 linear_to_srgb(vec3 c) {
    return mix(
        c * 12.92,
        1.055 * pow(c, vec3(1.0 / 2.4)) - 0.055,
        step(vec3(0.0031308), c)
    );
}

vec3 rgb_to_lms(vec3 c) {
	return xyz_to_lms(linear_to_xyz(srgb_to_linear(c)));
}

vec3 lms_to_rgb(vec3 c) {
	return linear_to_srgb(xyz_to_linear(lms_to_xyz(c)));
}

void fragment() {
	vec4 base_colour = texture(TEXTURE, UV);
	vec4 overlay_colour = texture(overlay, UV);
	
	vec3 base_colour_3 = base_colour.rgb;
	vec3 overlay_colour_3 = vec3(1,1,1) - overlay_colour.rgb;
	
	base_colour_3 = rgb_to_lms(base_colour_3);
	base_colour_3 *= tint;
	base_colour_3 = lms_to_rgb(base_colour_3);
	
	overlay_colour_3 = rgb_to_lms(overlay_colour_3);
	overlay_colour_3 *= overlay_tint;
	overlay_colour_3 = lms_to_rgb(overlay_colour_3);
	
	vec3 mixed = mix(base_colour_3, overlay_colour_3, overlay_colour.a);
	
	float diag = UV.x + UV.y;
	float cycle = 2.0 + glint_pause;
	float pos = mod(TIME * glint_speed, cycle);
	float glint_power = smoothstep(pos - glint_width, pos, diag) - smoothstep(pos, pos + glint_width, diag);
	mixed += vec3(1,1,1) * glint_intensity * glint_power;
	
	mixed *= 1.5;
	
	mixed = clamp(mixed, 0, 1);
	
	COLOR = vec4(mixed, base_colour.a);
}
