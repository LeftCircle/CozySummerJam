shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
// 1. 新增一個遮罩貼圖的欄位
uniform sampler2D mask_texture : hint_default_white; 

uniform sampler2D noise1 : repeat_enable;
uniform sampler2D noise2 : repeat_enable;
uniform vec2 scroll1 = vec2(0.05, 0.05);
uniform vec2 scroll2 = vec2(-0.05, -0.05);
uniform float distortion_strength : hint_range(-1, 1) = 0.2;
uniform vec4 tone_color : source_color;
uniform vec4 top_color : source_color;
uniform float light_start: hint_range(0.0, 1.0) = 0.275;
uniform float light_end: hint_range(0.0, 1.0) = 0.4;

void fragment(){
    // 2. 讀取遮罩的數值（通常取紅色通道 .r 即可）
    float mask = texture(mask_texture, UV).r;
    
    float depth = texture(noise1, UV + scroll1*TIME).r * texture(noise2, UV + scroll2*TIME).r;
    
    // 3. 讓扭曲強度（distortion）受到遮罩控制（陸地不扭曲）
    vec4 screen_col = texture(SCREEN_TEXTURE, SCREEN_UV + (distortion_strength * mask) * vec2(depth));
    
    // 4. 讓反光效果（top_light）乘以遮罩（陸地不發光）
    vec4 top_light = smoothstep(light_start, light_end, depth) * top_color * mask;
    
    // 5. 混合最終顏色：如果是水面(mask=1)就套用效果，如果是陸地(mask=0)就維持原本螢幕顏色
    vec4 water_color = screen_col * tone_color + top_light;
    COLOR = mix(screen_col, water_color, mask);
    COLOR.a = 1.0;
}