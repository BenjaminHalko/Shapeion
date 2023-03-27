if !OPERA {
	if(os_browser != browser_not_a_browser) {
		if(browser_width != width || browser_height != height) {
			width = browser_width;
			height = browser_height;
			scale_canvas();
		}
	} else {
		if(window_get_width() != width || window_get_height() != height) {
			width = window_get_width();
			height = window_get_height();
			ResizeScreen();
		}
	}
}

if(title) {
	startPercent = ApproachFade(startPercent,global.hardMode != -1,0.2,0.8);
	if(alarm[3] <= 0 and startPercent == 0) alarm[3] = room_speed*5;
	titleAlpha = ApproachFade(titleAlpha,!menuFadeOut,0.1,0.8);
	volAlpha = ApproachFade(volAlpha,0.4+0.3*((point_in_rectangle(mouse_x,mouse_y,xMin+8,yMax-80,xMin+28,yMax-12) and !MOBILE) or volClick),0.2,0.8);
	if(point_in_rectangle(mouse_x,mouse_y,xMin+12,yMax-80,xMin+32,yMax-12) && mouse_check_button_pressed(mb_left)) volClick = true;
	else if(!mouse_check_button(mb_left)) volClick = false;
	if(volClick) {
		vol = median(0,1,1-(mouse_y-yMax+74)/56);
		audio_sound_gain(mMusic,vol,0);
	}
	if(titleAlpha == 0 && !instance_exists(oShapeGet)) {
		title = false;
		newrecord = false;
		menuFadeOut = false;
		instance_create_layer(room_width/2,yMax+64,"Player",oPlayer);
		oGUI.alarm[0] = 15;
		audio_play_sound(snReady,1,false);
	}
	if(keyboard_check_pressed(vk_backspace) and MOBILE and os_browser == browser_not_a_browser) game_end();
} else if(!instance_exists(oWall) && global.lives > 0 && start && !tempStop) instance_create_layer(0,0,"Wall",oWall);

global.expandSpeed = 0.001+0.0001*global.score/100+0.006*global.hardMode;

function backToMenu() {
	instance_destroy(oPlayer);
	instance_destroy(oShapeGet);
	instance_destroy(oWall);
	
	SubmitScore();

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

if(point_in_rectangle(mouse_x,mouse_y,xMin+8,yMax-40,xMin+40,yMax-8)) {
	backAlpha = ApproachFade(backAlpha,1,0.1,0.8);
	if(mouse_check_button_pressed(mb_left)) backToMenu();
} else backAlpha = ApproachFade(backAlpha,0,0.1,0.8);

if(keyboard_check_pressed(vk_backspace) and MOBILE) backToMenu();

if (os_type == os_android) {
	if(point_in_rectangle(mouse_x,mouse_y,xMax-60,yMax-60,xMax-8,yMax-8)) {
		playAlpha = ApproachFade(playAlpha,1,0.1,0.8);
		if(mouse_check_button_pressed(mb_left)) GooglePlayServices_Leaderboard_ShowAll();
	} else playAlpha = ApproachFade(playAlpha,0,0.1,0.8);
}
	
if(keyboard_lastkey != -1) {
	if(keyboard_lastkey == secretCode[codeNum]) {
		codeNum++;
		if(array_length(secretCode) == codeNum) {
			codeActivated = !codeActivated;
			codeNum = 0;
		}
	} else codeNum = 0;	
	keyboard_lastkey = -1;
}
