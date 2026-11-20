shader_type canvas_item;

uniform sampler2D albedo_tex : source_color;
uniform sampler2D pattern_tex_1 : source_color, hint_default_transparent, repeat_enable;
uniform sampler2D pattern_tex_2 : source_color, hint_default_transparent, repeat_enable;

instance uniform int pattern_index = 0;
instance uniform vec3 tint = vec3(1.0, 1.0, 1.0);

// https://mk.bcgsc.ca/colorblind/math.mhtml

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

// Convert Linear RGB to sRGB
vec3 linear_to_srgb(vec3 c) {
    return mix(
        c * 12.92,
        1.055 * pow(c, vec3(1.0 / 2.4)) - 0.055,
        step(vec3(0.0031308), c)
    );
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 tex_colour = texture(albedo_tex, UV);
	
	vec4 pattern_colour;
	if (pattern_index == 1) {
		pattern_colour = texture(pattern_tex_1, UV * .75);
	}
	else if (pattern_index == 2) {
		pattern_colour = texture(pattern_tex_2, UV);
	}
	else {
		pattern_colour = vec4(0);
	}
	
	vec3 pattern_colour_adj = .5 * (vec3(1) - pattern_colour.rgb);
	
	//vec3 srgb_colour = tex_colour.rgb;
	vec3 srgb_colour = mix(tex_colour.rgb, pattern_colour_adj, pattern_colour.a);
	
	vec3 linear_rgb_colour = srgb_to_linear(srgb_colour);
	vec3 xyz_colour = linear_to_xyz(linear_rgb_colour);
	vec3 lms_colour = xyz_to_lms(xyz_colour);
	
	lms_colour = lms_colour * tint;
	
	xyz_colour = lms_to_xyz(lms_colour);
	linear_rgb_colour = xyz_to_linear(xyz_colour);
	srgb_colour = linear_to_srgb(linear_rgb_colour);
	
	vec3 clamped_colour = clamp(srgb_colour, 0.0, 1.0);
    COLOR = vec4(clamped_colour, tex_colour.a);
}
