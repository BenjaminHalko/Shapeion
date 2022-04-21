/// @desc

var _size = size*animcurve_channel_evaluate(curve,percent);
var _angle = min(1,animcurve_channel_evaluate(curve,percent))*180+angle;

x = lerp(xstart,oPlayer.x,1-min(1,animcurve_channel_evaluate(curve,percent)));
y = lerp(ystart,oPlayer.y,1-min(1,animcurve_channel_evaluate(curve,percent)));

draw_primitive_begin(pr_linelist);
for(var i = 0; i < num; i++) {
	draw_vertex(x+lengthdir_x(_size,360/num*i+_angle),y+lengthdir_y(_size,360/num*i+_angle));
	draw_vertex(x+lengthdir_x(_size,360/num*(i+1)+_angle),y+lengthdir_y(_size,360/num*(i+1)+_angle));
}
draw_primitive_end();

percent += 0.03;
if(percent <= 0) instance_destroy();
