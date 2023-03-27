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

	ResizeScreen();
}

function draw_line_shadow(_array,_width=2,_col=c_black) {
	if(_col != c_black) 	for(var i = 0; i < array_length(_array); i++) draw_line_width_color(_array[i][0],_array[i][1],_array[i][2],_array[i][3],_width+4,_col,_col);
	for(var i = 0; i < array_length(_array); i++) draw_line_width_color(_array[i][0],_array[i][1],_array[i][2],_array[i][3],_width+2,c_black,c_black);
	for(var i = 0; i < array_length(_array); i++) draw_line_width(_array[i][0],_array[i][1],_array[i][2],_array[i][3],_width);
}

function setColorOpposite() {
	var _col = color_get_hue(oGlobalController.currentColor)+128;
	if(_col > 255) _col -= 255;
	draw_set_color(make_color_hsv(_col,255,255));
}

function ResizeScreen() {
	var _ratio = window_get_width()/window_get_height();
	
	if(_ratio == WIDTH/HEIGHT or window_get_width() <= 0 or window_get_height <= 0) return;
	
	var _width, _height;
	
	if(_ratio > 1) {
		_width = round(540*_ratio);
		_height = 540;
	} else {
		_width = 540;
		_height = round(540/_ratio);
	}
	
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
