shader_type canvas_item;
uniform int mode = 0;
void fragment() {
	vec4 px = texture(SCREEN_TEXTURE, SCREEN_UV);
	if (mode==1)
	{
		float rgDiff = px.r / px.g;
		float grDiff = px.g / px.r;
		px.rg *= rgDiff>1.0?rgDiff:1.0;
		px.b *= grDiff>1.0?grDiff:1.0;
		px *= px.r / (px.r + px.g) * 2.0;
	}
	else if (mode==2)
	{
		float ybDiff = px.r + px.g / (px.b * 2.0);
		float byDiff = (2.0 * px.b) / px.r + px.g;
		float brightness = (px.r + px.g + px.b) / 1.5;
		px.r *= (ybDiff > 1.0 ? ybDiff : 1.0) * brightness;
		px.g *= (byDiff > 1.0 ? byDiff : 1.0) * brightness;
	}
	else
	{
		// Invalid mode
		// Random crazy filter
		// If this filter is shown, there's a bug
		px = px.rrbb;
	}
	COLOR = vec4(px.rgb,1.0);
} 