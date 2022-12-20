shader_type canvas_item;



uniform float pixel_size: hint_range(1, 8, 1) = 2;
uniform bool adjust_luminosity = true; 
uniform int nb_band_lights: hint_range(0, 256);
uniform float contrast: hint_range(0.5, 1.5);
uniform float brightness: hint_range(-0.5, 0.5);


float luminance(vec3 col){
	return (col.r * 0.299) + (col.g * 0.587) + (col.b * 0.114);
}

float frac(float v)
{
  return v - floor(v);
}
vec3 lerp(vec3 v0, vec3 v1, float t) {
  return v0 + t * (v1 - v0);
}
float hue(vec3 rgb){
	float maxComponent = max(rgb.r, max(rgb.g, rgb.b));
    float minComponent = min(rgb.r, min(rgb.g, rgb.b));
    float diff = maxComponent - minComponent;
    float hue = 0.0;
    if(maxComponent == rgb.r) {
        hue = (rgb.g-rgb.b)/diff;
    } 
	else if(maxComponent == rgb.g) {
        hue = 2.0+(rgb.b-rgb.r)/diff;
    }
	 else if(maxComponent == rgb.b) {
        hue = 4.0+(rgb.r-rgb.g)/diff;
    }
    hue /= 6.0;
	return hue; 
}
vec3 rgb_to_hsv(vec3 rgb)
{
    float maxComponent = max(rgb.r, max(rgb.g, rgb.b));
    float minComponent = min(rgb.r, min(rgb.g, rgb.b));
    float diff = maxComponent - minComponent;
    float hue = 0.0;
    if(maxComponent == rgb.r) {
        hue = (rgb.g-rgb.b)/diff;
    } 
	else if(maxComponent == rgb.g) {
        hue = 2.0+(rgb.b-rgb.r)/diff;
    }
	 else if(maxComponent == rgb.b) {
        hue = 4.0+(rgb.r-rgb.g)/diff;
    }
    hue /= 6.0;
    float saturation = diff / maxComponent;
    float value = maxComponent;
	float lightness = (rgb.r+rgb.g+rgb.b)/3.0;
    return vec3(hue, saturation*value, value);//lightness); //value);
}

vec3 hue_to_rgb(float hue) {
    hue = frac(hue); //only use fractional part of hue, making it loop
    float r = abs(hue * 6. - 3.) - 1.; //red
    float g = 2. - abs(hue * 6. - 2.); //green
    float b = 2. - abs(hue * 6. - 4.); //blue
    vec3 rgb = vec3(r,g,b); //combine components
    rgb = clamp(rgb, 0.,1.); //clamp between 0 and 1
    return rgb;
}

vec3 hsv_to_rgb(vec3 hsv)
{
    vec3 rgb = hue_to_rgb(hsv.x); //apply hue
    rgb = lerp(vec3(1), rgb, hsv.y); //apply saturation
    rgb = rgb * hsv.z; //apply value
    return rgb;
}
 
void fragment() {
	
    vec2 iRes = 1.0 / SCREEN_PIXEL_SIZE;
    
    float onePixelSizeX = 1.0 / iRes.x;
    float onePixelSizeY = 1.0 / iRes.y;
    
    float cellSizeX =  float(pixel_size) * onePixelSizeX;
    float cellSizeY = float(pixel_size) * onePixelSizeY; 
    
    vec2 uv = vec2(cellSizeX * floor(UV.x / cellSizeX), cellSizeY * floor(UV.y / cellSizeY));
    vec3 color = textureLod(TEXTURE, uv, 0.0).rgb;
	
	if(adjust_luminosity){ 
		// Adjust luminosity
		float lum = luminance(color);
		color -= vec3(lum);
		// adjust brightness, contrast
		lum = (lum - 0.5 + brightness) * contrast + 0.5;
		//lum = clamp(lum, 0.0, 1.0);
		// Band-limited light
		float bits = float(nb_band_lights);
		lum = floor(lum * bits) / bits;
		color += vec3(lum);
	}
	COLOR.rgb = color;
}
