if(os_browser != browser_not_a_browser) and (browser_width != width || browser_height != height)
{
	width = browser_width;
	height = browser_height;
	scale_canvas(960,540,width,height);
	
}
if(title) {
	startPercent = ApproachFade(startPercent,global.hardMode != -1,0.2,0.8);
	if(alarm[3] <= 0 and startPercent == 0) alarm[3] = room_speed*5;
	titleAlpha = ApproachFade(titleAlpha,!menuFadeOut,0.1,0.8);
	if(titleAlpha == 0 && !instance_exists(oShapeGet)) {
		title = false;
		newrecord = false;
		menuFadeOut = false;
		instance_create_layer(room_width/2,room_height+64,"Player",oPlayer);
		oGUI.alarm[0] = 15;
		audio_play_sound(snReady,1,false);
	}
} else if(!instance_exists(oWall) && global.lives > 0 && start && !tempStop) instance_create_layer(0,0,"Wall",oWall);

global.expandSpeed = 0.001+0.0001*global.score/100+0.006*global.hardMode;

if(point_in_rectangle(mouse_x,mouse_y,8,room_height-40,40,room_height-8)) {
	backAlpha = ApproachFade(backAlpha,1,0.1,0.8);
	if(mouse_check_button_pressed(mb_left)) {
		instance_destroy(oPlayer);
		instance_destroy(oShapeGet);
		instance_destroy(oWall);

		title = true;
		menuFadeOut = false;
		global.hardMode = -1;

		global.score = 0;

		menuPercent = [0,0];
		tempStop = false;

		oGUI.alarm[0] = -1;
		oGUI.alarm[1] = -1;

		oGUI.start = 8;
		start = false;

		alarm[1] = -1;
		alarm[2] = -1;
		alarm[4] = -1;
	}
} else backAlpha = ApproachFade(backAlpha,0,0.1,0.8);

if(!codeActivated and keyboard_lastkey != -1) {
	if(keyboard_lastkey == secretCode[codeNum]) {
		codeNum++;
		if(array_length(secretCode) == codeNum) codeActivated = true;
	} else codeNum = 0;	
	keyboard_lastkey = -1;
}
