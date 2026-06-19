shader_type canvas_item;
render_mode unshaded, blend_add;

void fragment() {
    vec2 p = UV - vec2(0.5);
    float d = length(p) * 2.0;

    float core = smoothstep(0.20, 0.0, d);
    float glow = smoothstep(1.0, 0.20, d) * 0.35;

    vec3 col = vec3(3.0, 3.5, 5.0) * (core + glow);
    float alpha = clamp(core + glow, 0.0, 1.0);

    COLOR = vec4(col, alpha);
}