/// @desc

var _w = room_width/global.smallStart;
var _h = room_height/global.smallStart;

draw_set_color(c_red);
draw_line(0,0,room_width/2-_w,room_height/2-_h);
draw_line(room_width,0,room_width/2+_w,room_height/2-_h);
draw_line(0,room_height,room_width/2-_w,room_height/2+_h);
draw_line(room_width,room_height,room_width/2+_w,room_height/2+_h);
draw_rectangle(room_width/2-_w,room_height/2-_h,room_width/2+_w,room_height/2+_h,true);

for(var i = 0; i < array_length(rectangles); i++) {
	draw_rectangle(room_width/2*(1-rectangles[i]),room_height/2*(1-rectangles[i]),room_width/2*(1+rectangles[i]),room_height/2*(1+rectangles[i]),true);
	rectangles[i] += global.expandSpeed;
	if(rectangles[i] > 1) {
		array_delete(rectangles,i,1);
		i--;
	}
}
