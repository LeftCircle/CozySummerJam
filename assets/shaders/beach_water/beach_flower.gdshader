shader_type canvas_item;
render_mode unshaded, blend_add;

uniform sampler2D mask_texture;
uniform vec2 mask_texel_size = vec2(0.004, 0.004); 
uniform vec4 glow_color : source_color = vec4(0.2, 0.8, 1.0, 1.0);

uniform float body_strength = 2.5;   
uniform float glow_strength = 6.0;   
uniform float glow_radius = 18.0;   
uniform int samples = 24;
uniform int rings = 6;

float mask_at(vec2 uv) {
    return texture(mask_texture, uv).r;
}

void fragment() {
    float center = mask_at(UV);

    float blur_sum = 0.0;
    float blur_count = 0.0;

    for (int r = 1; r <= 8; r++) {
        if (r > rings) break;

        float fr = float(r) / float(rings);
        float radius = glow_radius * fr;
        float ring_weight = exp(-2.0 * fr);

        for (int i = 0; i < 32; i++) {
            if (i >= samples) break;

            float ang = TAU * float(i) / float(samples);
            vec2 dir = vec2(cos(ang), sin(ang));
            vec2 uv2 = UV + dir * mask_texel_size * radius;

            blur_sum += mask_at(uv2) * ring_weight;
            blur_count += ring_weight;
        }
    }

    float blurred = 0.0;
    if (blur_count > 0.0) {
        blurred = blur_sum / blur_count;
    }

    float body = pow(center, 0.85) * body_strength;
    float halo = max(blurred - center * 0.4, 0.0) * glow_strength;

    vec3 rgb = glow_color.rgb * (body + halo);
    float a = clamp(center + halo * glow_color.a, 0.0, 1.0);

    COLOR = vec4(rgb, a);
}