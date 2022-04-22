/// @desc

randomize();

global.expandSpeed = 0.001;
global.smallStart = 14;

global.score = 0;
if(file_exists("score")) {
	var _file = file_text_open_read("score");
	global.hiScore = file_text_read_real(_file);
	file_text_close(_file);
	if(is_nan(global.hiScore)) global.hiScore = 0;
} else global.hiScore = 0;

global.lives = 6;

rectangles = [];

alarm[0] = 1;

width = browser_width;
height = browser_height;
scale_canvas(960,540,width,height);

lastColor = make_color_hsv(irandom(255),255,255);
currentColor = make_color_hsv(irandom(255),255,255);

colorPercent = 1;

start = false;

tempStop = false;
title = true;

blink = false;
alarm[2] = 30;
