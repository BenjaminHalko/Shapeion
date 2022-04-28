/// @desc

global.challengeID = [
"f010edca-0b09-4803-9452-487f4ce65457",
"cbe0c54a-609d-4fad-bac3-13a568e45050"];

#macro OPERA (os_type == os_operagx)
#macro MOBILE (os_type == os_android or os_type == os_ios)
#macro MAXLIVES 6

#macro WIDTH camera_get_view_width(view_camera[0])
#macro HEIGHT camera_get_view_height(view_camera[0])

#macro xMin (room_width-WIDTH)/2
#macro yMin (room_height-HEIGHT)/2
#macro xMax (room_width-xMin)
#macro yMax (room_height-yMin)

randomize();

global.expandSpeed = 0;
global.smallStart = 14;

global.hardMode = -1;

global.score = 0;

challengeCurrent = undefined;

secretCode = [vk_up,vk_up,vk_down,vk_down,vk_left,vk_right,vk_left,vk_right];
codeNum = 0;
codeActivated = false;

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


if(os_browser != browser_not_a_browser) {
	width = browser_width;
	height = browser_height;
	scale_canvas(960,540,width,height);
} else {
	width = window_get_width();
	height = window_get_height();	
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

if(!audio_is_playing(mMusic)) audio_play_sound(mMusic,1,true);
