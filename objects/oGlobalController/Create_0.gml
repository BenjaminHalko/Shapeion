/// @desc

global.expandSpeed = 0.005;
global.smallStart = 16;

global.score = 0;
global.hiScore = 0;

global.lives = 3;

rectangles = [];

alarm[0] = 1;

width = browser_width;
height = browser_height;
scale_canvas(960,540,width,height);

lastColor = make_color_hsv(irandom(255),255,255);
currentColor = make_color_hsv(irandom(255),255,255);

colorPercent = 1;

col = 0;
