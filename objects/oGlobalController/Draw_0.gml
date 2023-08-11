/// @desc

var _w = WIDTH/global.smallStart;
var _h = HEIGHT/global.smallStart;

if(codeActivated) {
	currentColor = make_color_hsv(irandom(255),255,255);
	colorPercent = 1;
}
colorPercent = Approach(colorPercent,1,0.05);
draw_set_color(merge_color(lastColor,currentColor,colorPercent));
draw_line(xMin,yMin,room_width/2-_w,room_height/2-_h);
draw_line(xMax,yMin,room_width/2+_w,room_height/2-_h);
draw_line(xMin,yMax,room_width/2-_w,room_height/2+_h);
draw_line(xMax,yMax,room_width/2+_w,room_height/2+_h);
draw_rectangle(room_width/2-_w,room_height/2-_h,room_width/2+_w,room_height/2+_h,true);

for(var i = 0; i < array_length(rectangles); i++) {
	draw_rectangle(xMin+WIDTH/2*(1-rectangles[i]),yMin+HEIGHT/2*(1-rectangles[i]),xMin+WIDTH/2*(1+rectangles[i]),yMin+HEIGHT/2*(1+rectangles[i]),true);
	rectangles[i] += 0.01*median(0.01,rectangles[i]*1.5-0.1,1);
	if(rectangles[i] > 1) {
		array_delete(rectangles,i,1);
		i--;
	}
}

if(title) {
	var _titleSize = min(1,WIDTH/960+0.2)
	var _col = color_get_hue(merge_color(lastColor,currentColor,colorPercent))+128;
	if(_col > 255) _col -= 255;
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fontGui);
	
	if os_type != os_android {
		draw_set_color(c_white);
		draw_set_alpha(volAlpha*titleAlpha);
		draw_line_width(xMin+22,yMax-74,xMin+22,yMax-18,2);
		draw_circle(xMin+22,lerp(yMax-18,yMax-74,vol),6,false);
		draw_sprite(sSound,0,xMin+22,yMax-84);
		draw_set_alpha(1);
	} else {
		
		if settingsMenu draw_sprite_ext(sBack,0,xMax-72-guiXRight,yMax-8-oGUI.guiYBottom,2,2,0,c_white,lerp(0.4,0.7,settingsAlpha));
		else {
			draw_set_alpha(lerp(0.4,0.7,settingsAlpha)*titleAlpha);
			draw_sprite(sSettings,0,xMax-72-guiXRight,yMax-8-oGUI.guiYBottom);
			draw_set_alpha(1);
		}
	}
	
	if(!menuFadeOut) {
		var _drawX = 150;
		var _drawY = room_height/4*3+20;
	
		var _angle = 90;
		var _size = 80;
		for(var j = 0; j < 2; j++) {
			var _shapeArray = [];
			var _shapeArrayCol = [];
	
			var _num = 4+j*2;
			var _xPos = room_width/2-_drawX*(1-j*2)*(1-startPercent*(global.hardMode == j))*_titleSize;
		
			var _pointIn = false;
			if !settingsMenu {
				if(challengeCurrent == undefined or challengeCurrent == global.challengeID[j]) {
					for(var i = 0; i < _num; i++) {
						if(point_in_triangle(mouse_x,mouse_y,_xPos,_drawY,_xPos+lengthdir_x(_size,360/_num*i+_angle),_drawY+lengthdir_y(_size,360/_num*i+_angle),_xPos+lengthdir_x(_size,360/_num*(i+1)+_angle),_drawY+lengthdir_y(_size,360/_num*(i+1)+_angle))) {
							_pointIn = true;
							break;
						}
					}
					if !_pointIn menuAllow[j] = 1;
					else if MOBILE and !menuAllow[j] _pointIn = false;
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
			
			var _buttonCol = [c_grey,c_white];
			if(global.hardMode != j or blink) {
				draw_set_alpha((1-startPercent*(global.hardMode != j))*(.5+.5*(challengeCurrent == undefined or challengeCurrent == global.challengeID[j]))*(1-settingsMenuAlpha));
				draw_set_color(_buttonCol[challengeCurrent == undefined or challengeCurrent == global.challengeID[j]]);
				if(j == 0) draw_text(_xPos,_drawY,"NORMAL");
				else draw_text(_xPos,_drawY,"HARD");
				draw_line_shadow(_shapeArray);
				draw_set_alpha(1);
			}
		
			setColorOpposite();
			draw_line_shadow(_shapeArrayCol,5);
		}
	}
	
	// Settings
	if settingsMenuAlpha != 0 {
		draw_set_alpha(settingsMenuAlpha);
		BGMSlider.draw();
		LeaderboardButton.draw();
		AchievementButton.draw();
		PrivacyPolicyButton.draw();
		draw_set_alpha(1);
	}
			
	//Title
	draw_sprite_ext(sTitle,1,room_width/2,room_height/2-50-(40+65*(width / height < 1.15)+20*(width / height < 0.7))*settingsMenuAlpha,4*_titleSize,4*_titleSize,0,make_color_hsv(_col,255,255),titleAlpha);
	draw_sprite_ext(sTitle,0,room_width/2,room_height/2-50-(40+65*(width / height < 1.15)+20*(width / height < 0.7))*settingsMenuAlpha,4*_titleSize,4*_titleSize,0,c_white,titleAlpha);
}

if(oGUI.start % 2) {
	if(newrecord) {
		draw_set_color(c_red);
		draw_text(room_width/2,yMin+64+oGUI.guiY,"NEW RECORD");
	}
}

var _scale = 1 + MOBILE
draw_sprite_ext(sBack,0,xMin+8+guiXLeft,yMax-8-oGUI.guiYBottom,_scale,_scale,0,c_white,lerp(0.2,0.8,backAlpha)*(1-titleAlpha));