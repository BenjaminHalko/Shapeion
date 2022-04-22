/// @desc

var _w = room_width/global.smallStart;
var _h = room_height/global.smallStart;

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

if(title) {
	draw_sprite_ext(sTitle,0,room_width/2,room_height/2-50,2,2,0,c_white,1);
	if(blink) {
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_font(fontGui);
		draw_text(room_width/2,room_height/4*3,"CLICK ANYWHERE");	
	}
}
