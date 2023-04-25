/// @desc

global.challengeID = [
"f010edca-0b09-4803-9452-487f4ce65457",
"cbe0c54a-609d-4fad-bac3-13a568e45050"];

global.leaderboardID = [
"CgkInLT-qa4UEAIQAA",
"CgkInLT-qa4UEAIQAQ"];

#macro OPERA (os_type == os_operagx)
#macro MOBILE (os_type == os_android or os_type == os_ios)
#macro MAXLIVES 6

#macro WIDTH camera_get_view_width(view_camera[0])
#macro HEIGHT camera_get_view_height(view_camera[0])

#macro xMin (room_width-WIDTH)/2
#macro yMin (room_height-HEIGHT)/2
#macro xMax (room_width-xMin)
#macro yMax (room_height-yMin)

#macro sizeRatio ((max(WIDTH,HEIGHT)/960+min(WIDTH,HEIGHT)/540)/2)

randomize();

global.expandSpeed = 0;
global.smallStart = 14;

global.hardMode = -1;

global.score = 0;

challengeCurrent = undefined;

secretCode = [vk_up,vk_up,vk_down,vk_down,vk_left,vk_right,vk_left,vk_right];
codeNum = 0;
codeActivated = false;

global.notched = NOTCH_is();

if(OPERA) {
	challengeCurrent = gxc_get_query_param("challenge");
	global.hiScore = [0,0];
	try gxc_challenge_get_global_scores(function(_status, _result) {
		try if (_status == 200 and array_length(_result.data.scores) > 0) global.hiScore[0] = _result.data.scores[0].score;
		catch(_error) show_debug_message(_error);
	},{challengeId: global.challengeID[0]});
	
	try gxc_challenge_get_global_scores(function(_status, _result) {
		try if (_status == 200 and array_length(_result.data.scores) > 0) global.hiScore[1] = _result.data.scores[0].score;
		catch(_error) show_debug_message(_error);
	},{challengeId: global.challengeID[1]});
	catch(_error) show_debug_message(_error);
} else {
	ini_open("score.ini");
	global.hiScore = [
	ini_read_real("score","normal",0),
	ini_read_real("score","hard",0)];
	ini_close();
}
	
global.lives = MAXLIVES;

rectangles = [];

alarm[0] = 1;

if !OPERA {
	if(os_browser != browser_not_a_browser) {
		width = browser_width;
		height = browser_height;
		scale_canvas();
	} else {
		width = window_get_width();
		height = window_get_height();
		ResizeScreen();
	}
}

lastColor = c_black;
currentColor = make_color_hsv(irandom(255),255,255);

colorPercent = 1;

start = false;

tempStop = false;
title = true;

blink = false;
blinkSpd = 5;
newrecord = false;

menuPercent = [0,0];

startPercent = 0;
titleAlpha = 1;

menuFadeOut = false;

backAlpha = 0;
settingsAlpha = 0;

settingsMenu = false;
settingsMenuAlpha = 0;

ini_open("score.ini");
vol = ini_read_real("settings","bgm",0.7);
ini_close();
volAlpha = 0.6;
volClick = false;

if(!audio_is_playing(mMusic)) audio_play_sound(mMusic,1,true,vol);

// Settings
function Settings(_name,_num) constructor {
	name = _name;
	num = _num
	percent = 0;
	clicked = false;
	x = 0;
	y = 0;
	
	width = 300;
	height = 70;
	sideMargin = 30;
	
	if num == 0 {
		percent = oGlobalController.vol;	
	}
	
	step = function() {
		// Position
		if oGlobalController.width / oGlobalController.height >= 1.15 {
			x = room_width/2 + (width / 2 + 20) * (-1 + (num == 0 or num == 3) * 2);
			y = room_height/4*3-20 + (height / 2 + 20) * (-1 + (num < 2) * 2);
		} else {
			x = room_width/2;
			y = room_height/2 - 55 + (height + 20 + 20 * (oGlobalController.width / oGlobalController.height < 0.7)) * num;
		}
		
		if num != 0 {
			percent = ApproachFade(percent,clicked * mouse_check_button(mb_left) * point_in_rectangle(mouse_x,mouse_y,x-width/2,y-height/2,x+width/2,y+height/2),0.035,0.7);	
		
			if mouse_check_button_pressed(mb_left) * point_in_rectangle(mouse_x,mouse_y,x-width/2,y-height/2,x+width/2,y+height/2) clicked = true;
			else if !mouse_check_button(mb_left) clicked = false;
		
			if percent == 1 {
				if num == 1 {
					GooglePlayServices_Leaderboard_ShowAll();	
				} else if num == 2 {
					GooglePlayServices_Achievements_Show();	
				} else if num == 3 {
					url_open("https://benjamin.halko.ca/privacy-policy/shapeion.html");	
				}
				clicked = false;
			}
		} else {
			if !clicked {
				if mouse_check_button_pressed(mb_left) * point_in_rectangle(mouse_x,mouse_y,x-width/2,y-height/2,x+width/2,y+height/2) clicked = true;
			} else {
				percent = ApproachFade(percent,oGlobalController.vol,1,0.8);
				var _newVol = round(median(0,1,(mouse_x-x+width/2)/width)*10)/10;
				if _newVol != oGlobalController.vol {
					oGlobalController.vol = _newVol;
					audio_sound_gain(mMusic,oGlobalController.vol,0);
					ini_open("score.ini");
					ini_write_real("settings","bgm",oGlobalController.vol);
					ini_close();
				}
				
				if !mouse_check_button(mb_left)	clicked = false;
			}
		}
	}
	
	draw = function() {
		var _shapeArray = [
			[x-width/2, y, x-width/2+sideMargin, y-height/2],
			[x-width/2+sideMargin,y-height/2,x+width/2-sideMargin,y-height/2],
			[x+width/2-sideMargin,y-height/2,x+width/2,y],
			[x+width/2,y,x+width/2-sideMargin,y+height/2],
			[x+width/2-sideMargin,y+height/2,x-width/2+sideMargin,y+height/2],
			[x-width/2+sideMargin,y+height/2,x-width/2,y]
		];
		
		if num == 0 {
			setColorOpposite();
			var _sidePercent = sideMargin / width;
			var _dir = point_direction(0,0,sideMargin,-height/2);
			var _alpha = draw_get_alpha();
			draw_set_alpha(_alpha*0.5);
			draw_triangle(x-width/2,y,x-width/2+min(sideMargin,percent*width),y-(min(1,percent*width/sideMargin)*height/2),x-width/2+min(sideMargin,percent*width),y+(min(1,percent*width/sideMargin)*height/2),false);
			if percent >= _sidePercent draw_rectangle(x-width/2+sideMargin,y-height/2,lerp(x-width/2+sideMargin,x+width/2-sideMargin-1,median(0,1,(percent-_sidePercent)*(width/(width-sideMargin*2)))),y+height/2,false);
			if percent >= 1 - _sidePercent {
				draw_primitive_begin(pr_trianglestrip);
				draw_vertex(x+width/2-sideMargin,y-height/2);
				draw_vertex(x+width/2-sideMargin,y+height/2);
				draw_vertex(x+width/2-sideMargin*(1-percent)/_sidePercent,y+height/2*(percent-1)/_sidePercent);
				draw_vertex(x+width/2-sideMargin*(1-percent)/_sidePercent,y-height/2*(percent-1)/_sidePercent);
				draw_primitive_end();
			}
			draw_set_alpha(_alpha);
		}
		
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		var _name = name;
		if num == 0 _name += ": "+string(round(oGlobalController.vol*100))+"%";
		draw_text(x,y,_name);
		draw_line_shadow(_shapeArray);
		
		setColorOpposite();
		if percent != 0 and num != 0 {
			var _side = width - sideMargin * 2;
			var _corner = point_distance(0,0,height/2,sideMargin);
			var _total = _side * 2 + _corner * 4;
			var _percent = percent * _total;
			var _shapeArrayCol = [];
			
			for(var i = 0; i < 6; i++) {
				var _type = i % 3 == 1 ? _side : _corner;
				var _thisPercent = min(_type,_percent) / _type;
				_percent -= _type;
				array_push(_shapeArrayCol,[
					_shapeArray[i][0],
					_shapeArray[i][1],
					lerp(_shapeArray[i][0],_shapeArray[i][2],_thisPercent),
					lerp(_shapeArray[i][1],_shapeArray[i][3],_thisPercent)
				]);
				if _percent <= 0 break;
			}
			
			draw_line_shadow(_shapeArrayCol,4);
		}
	}
}

BGMSlider = new Settings("BGM",0);
LeaderboardButton = new Settings("LEADERBOARDS",1);
AchievementButton = new Settings("ACHIEVEMENTS",2);
PrivacyPolicyButton = new Settings("PRIVACY POLICY",3);