vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
	vec4 c = Texel(texture, texture_coords);

	if(c.a !=  0){
		return vec4(255,255,255, 1);
	}
	else{
		return c;
	}
}