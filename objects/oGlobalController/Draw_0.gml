/// @desc

var _w = room_width/global.smallStart;
var _h = room_height/global.smallStart;

if(codeActivated) {
	currentColor = make_color_hsv(irandom(255),255,255);
	colorPercent = 1;
}
colorPercent = Approach(colorPercent,1,0.05);
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
	var _col = color_get_hue(merge_color(lastColor,currentColor,colorPercent))+128;
	if(_col > 255) _col -= 255;
	draw_sprite_ext(sTitle,1,room_width/2,room_height/2-50,4,4,0,make_color_hsv(_col,255,255),titleAlpha);
	draw_sprite_ext(sTitle,0,room_width/2,room_height/2-50,4,4,0,c_white,titleAlpha);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fontGui);
	
	if(!menuFadeOut) {
		var _drawX = 150;
		var _drawY = room_height/4*3+20;
	
		var _angle = 90;
		var _size = 80;
		for(var j = 0; j < 2; j++) {
			var _shapeArray = [];
			var _shapeArrayCol = [];
	
			var _num = 4+j*2;
			var _xPos = room_width/2-_drawX*(1-j*2)*(1-startPercent*(global.hardMode == j));
		
			var _pointIn = false;
			if(challengeCurrent == undefined or challengeCurrent == global.challengeID[j]) {
				for(var i = 0; i < _num; i++) {
					if(point_in_triangle(mouse_x,mouse_y,_xPos,_drawY,_xPos+lengthdir_x(_size,360/_num*i+_angle),_drawY+lengthdir_y(_size,360/_num*i+_angle),_xPos+lengthdir_x(_size,360/_num*(i+1)+_angle),_drawY+lengthdir_y(_size,360/_num*(i+1)+_angle))) {
						_pointIn = true;
						break;
					}
				}
			}
		
			if(global.hardMode == -1) menuPercent[j] = ApproachFade(menuPercent[j],_pointIn,0.035,0.7);
		
			for(var i = 0; i < _num; i++) {
				var _x = _xPos+lengthdir_x(_size,360/_num*i+_angle);
				var _y = _drawY+lengthdir_y(_size,360/_num*i+_angle);
		
				var _x2 = _xPos+lengthdir_x(_size,360/_num*(i+1)+_angle);
				var _y2 = _drawY+lengthdir_y(_size,360/_num*(i+1)+_angle);
		
				array_push(_shapeArray,[_x,_y,_x2,_y2]);
		
				if(menuPercent[j] > 1/_num*(_num-i-1)) {
					var _percent = min(1,menuPercent[j]*_num-(_num-i-1));
					array_push(_shapeArrayCol,[_x2,_y2,lerp(_x2,_x,_percent),lerp(_y2,_y,_percent)]);
				}
			
				if(menuPercent[j] == 1 and global.hardMode == -1) {
					global.hardMode = j;
					alarm[2] = blinkSpd;
					alarm[4] = 60;
					audio_play_sound(snStart,1,false);
					oGUI.hiScoreView = global.hardMode;
				}
			}
			
			var _col = [c_grey,c_white];
			if(global.hardMode != j or blink) {
				draw_set_alpha((1-startPercent*(global.hardMode != j))*(.5+.5*(challengeCurrent == undefined or challengeCurrent == global.challengeID[j])));
				draw_set_color(_col[challengeCurrent == undefined or challengeCurrent == global.challengeID[j]]);
				if(j == 0) draw_text(_xPos,_drawY,"NORMAL");
				else draw_text(_xPos,_drawY,"HARD");
				draw_line_shadow(_shapeArray);
				draw_set_alpha(1);
			}
		
			setColorOpposite();
			draw_line_shadow(_shapeArrayCol,4);
		}
	}
}

if(oGUI.start % 2) {
	if(newrecord) {
		draw_set_color(c_red);
		draw_text(room_width/2,64,"NEW RECORD");
	}
}

draw_set_alpha(lerp(0.2,0.8,backAlpha)*(1-titleAlpha));
draw_sprite(sBack,0,8,room_height-8)
draw_set_alpha(1);
