/// @desc

if(correct) {
	draw_set_color(c_white);
	var _size = size*animcurve_channel_evaluate(curve,percent);
	var _angle = min(1,animcurve_channel_evaluate(curve,percent))*180+angle+180;

	x = lerp(xstart,oPlayer.x,1-min(1,animcurve_channel_evaluate(curve,percent)));
	y = lerp(ystart,oPlayer.y,1-min(1,animcurve_channel_evaluate(curve,percent)));

	for(var i = 0; i < num; i++) {
		draw_line_width(x+lengthdir_x(_size,360/num*i+_angle),y+lengthdir_y(_size,360/num*i+_angle),
		x+lengthdir_x(_size,360/num*(i+1)+_angle),y+lengthdir_y(_size,360/num*(i+1)+_angle),2);
	}
} else {
	draw_text(x,y,thing);	
}

percent += 0.03;
if(percent >= 1) {
	if(correct) instance_create_depth(x,y-20,depth,oScore);
	instance_destroy();
}
