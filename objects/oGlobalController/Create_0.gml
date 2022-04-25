/// @desc

randomize();

global.expandSpeed = 0;
global.smallStart = 14;

global.hardMode = -1;

global.score = 0;
ini_open("score.ini");
global.hiScore = [
ini_read_real("score","normal",0),
ini_read_real("score","hard",0)];
ini_close();
	
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

if(!audio_is_playing(mMusic)) audio_play_sound(mMusic,1,true);
