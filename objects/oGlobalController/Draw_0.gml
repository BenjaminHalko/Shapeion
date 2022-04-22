/// @desc

var _w = room_width/global.smallStart;
var _h = room_height/global.smallStart;

//draw_set_color(make_color_hsv(irandom(255),255,255));
//draw_rectangle(0,0,room_width,room_height,0);

colorPercent = Approach(colorPercent,1,0.1);
draw_set_color(merge_color(lastColor,currentColor,colorPercent));
draw_line(0,0,room_width/2-_w,room_height/2-_h);
draw_line(room_width,0,room_width/2+_w,room_height/2-_h);
draw_line(0,room_height,room_width/2-_w,room_height/2+_h);
draw_line(room_width,room_height,room_width/2+_w,room_height/2+_h);
draw_rectangle(room_width/2-_w,room_height/2-_h,room_width/2+_w,room_height/2+_h,true);

for(var i = 0; i < array_length(rectangles); i++) {
	draw_rectangle(room_width/2*(1-rectangles[i]),room_height/2*(1-rectangles[i]),room_width/2*(1+rectangles[i]),room_height/2*(1+rectangles[i]),true);
	rectangles[i] += 0.01*median(0.01,rectangles[i]*1.5-0.1,1);
	if(rectangles[i] > 1) {
		array_delete(rectangles,i,1);
		i--;
	}
}
