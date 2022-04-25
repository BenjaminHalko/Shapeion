/// @desc

global.challengeID = [
"f010edca-0b09-4803-9452-487f4ce65457",
"cbe0c54a-609d-4fad-bac3-13a568e45050"];

#macro OPERA (os_type == os_operagx)

randomize();

global.expandSpeed = 0;
global.smallStart = 14;

global.hardMode = -1;

global.score = 0;

challengeCurrent = undefined;

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
	
global.lives = 6;

rectangles = [];

alarm[0] = 1;

width = browser_width;
height = browser_height;
if(os_browser != browser_not_a_browser) scale_canvas(960,540,width,height);

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
