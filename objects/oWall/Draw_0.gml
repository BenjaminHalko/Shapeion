draw_set_color(c_white);

draw_primitive_begin(pr_trianglelist);


var _num = round(Wave(3,8,5,0));
var _size = Wave(20,100,7,0);
image_angle++;
for(var i = 0; i < _num; i++) {
	draw_vertex(x,y);
	draw_vertex(x+lengthdir_x(_size,360/_num*i+image_angle),y+lengthdir_y(_size,360/_num*i+image_angle));
	draw_vertex(x+lengthdir_x(_size,360/_num*(i+1)+image_angle),y+lengthdir_y(_size,360/_num*(i+1)+image_angle));
}

draw_primitive_end()
