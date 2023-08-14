function Approach(a, b, amount) {
	if (a < b)
	{
	    a += amount;
	    if (a > b)
	        return b;
	}
	else
	{
	    a -= amount;
	    if (a < b)
	        return b;
	}
	return a;
}

function ApproachFade(Value,Target,MaxSpd,Ease) {
	Value += median(-MaxSpd,MaxSpd,(1-Ease)*(Target-Value));
	return Value;
}

function ApproachCircleEase(Value,Target,MaxSpd,Ease) {
	Value += median(-MaxSpd,MaxSpd,(1-Ease)*angle_difference(Target,Value));
	return Value
}

function Wave(_from, _to, _duration, _offset) {
	a4 = (_to - _from) * 0.5;
	return _from + a4 + sin((((current_time * 0.001) + _duration * _offset) / _duration) * (pi*2)) * a4;
}

function scale_canvas() {
	var _width = browser_width;
	var _height = browser_height;

	window_set_size(_width, _height);
	window_center();

	ResizeScreen(_width,_height);
}

function draw_line_shadow(_array,_width=3,_col=c_black) {
	var _line; 
	if(_col != c_black) {
		for(var i = 0; i < array_length(_array); i++) {
			_line = AdjustLine(_array[i],_width);
			draw_line_width_color(_line[0],_line[1],_line[2],_line[3],_width+6,_col,_col);
		}
	}
	for(var i = 0; i < array_length(_array); i++) {
		_line = AdjustLine(_array[i],_width);
		draw_line_width_color(_line[0],_line[1],_line[2],_line[3],_width+4,c_black,c_black);
	}
	for(var i = 0; i < array_length(_array); i++) {
		_line = AdjustLine(_array[i],_width);
		draw_line_width(_line[0],_line[1],_line[2],_line[3],_width);
	}
}

function setColorOpposite() {
	var _col = color_get_hue(merge_color(oGlobalController.lastColor,oGlobalController.currentColor,oGlobalController.colorPercent))+128;
	if(_col > 255) _col -= 255;
	draw_set_color(make_color_hsv(_col,255,255));
}

function ConfigNotch(_width,_height) {
	if global.notched {
		var _dir = display_get_orientation();
		var _displayRatio = _height/window_get_height();
		var _bottom = ceil(NOTCH_getBottom(_dir,"")*_displayRatio);
		if _dir == display_portrait or _dir == display_portrait_flipped {
			if _bottom < _height/2 {
				oGUI.guiY = _bottom;
			} else oGUI.guiY = 0;
		
			var _top = floor(NOTCH_getTop(_dir,"")*_displayRatio);
			if _top > _height/2 {
				oGUI.guiYBottom = _height-_top;
			} else oGUI.guiYBottom = 0;
			
			oGlobalController.guiXLeft = 0;
			oGlobalController.guiXRight = 0;
		} else {
			oGUI.guiY = 0;
			oGUI.guiYBottom = 0;
			
			if _bottom > _height - 75 {
				var _left = floor(NOTCH_getLeft(_dir,"")*_displayRatio);
				if _left > _width / 2 {
					oGlobalController.guiXRight = _width-_left;
				} else oGlobalController.guiXRight = 0;
				
				var _right = ceil(NOTCH_getRight(_dir,"")*_displayRatio);
				if _right < _width / 2 {
					oGlobalController.guiXLeft = _right;
				} else oGlobalController.guiXLeft = 0;
			}
		}
	}
}

function ResizeScreen(_baseWidth,_baseHeight) {
	var _ratio = _baseWidth/_baseHeight;
	
	var _width, _height;
	
	if(_ratio > 1) {
		_width = round(540*_ratio);
		_height = 540;
	} else {
		_width = 540;
		_height = round(540/_ratio);
	}
	
	ConfigNotch(_width,_height);
	
	if(_ratio == WIDTH/HEIGHT or _baseWidth <= 0 or _baseHeight <= 0) return;
	
	camera_set_view_size(view_camera[0],_width,_height);
	camera_set_view_pos(view_camera[0],480-_width/2,270-_height/2);
	
	view_wport[0] = _width;
	view_hport[0] = _height;
	
	if(instance_exists(oWall)) surface_free(oWall.surface);
	
	surface_resize(application_surface,_width,_height);
}

function SubmitScore() {
	if(global.hardMode != -1) {
		if(OPERA) {
			try gxc_challenge_submit_score(global.score,undefined,{challengeId: global.challengeID[global.hardMode]});
			catch(_error) show_debug_message(_error);
		}
		if(os_type == os_android) {
			GooglePlayServices_Leaderboard_SubmitScore(global.leaderboardID[global.hardMode],global.score,"");
		}
		if(global.score > global.hiScore[global.hardMode]) {
			global.hiScore[global.hardMode] = global.score;
			if(!OPERA) {
				var _mode = ["normal","hard"];
				ini_open("score.ini");
				ini_write_real("score",_mode[global.hardMode],global.score);
				ini_close();
			}
			oGlobalController.newrecord = true;
		}
	}
}

function GetShapeSide(_x,_y,_size,_angle1,_angle2) {
	var _x1 = _x+lengthdir_x(_size,_angle2);
	var _y1 = _y+lengthdir_y(_size,_angle2);
		
	var _x2 = _x+lengthdir_x(_size,_angle1);
	var _y2 = _y+lengthdir_y(_size,_angle1);
	
	return [_x1,_y1,_x2,_y2];
}

function AdjustLine(_line,_width) {
	var _dir = point_direction(_line[0],_line[1],_line[2],_line[3]);
	var _subtractX = lengthdir_x(_width/5*2,_dir);
	var _subtractY = lengthdir_y(_width/5*2,_dir);
	
	return [
		_line[0]-_subtractX,
		_line[1]-_subtractY,
		_line[2]+_subtractX,
		_line[3]+_subtractY
	];
}