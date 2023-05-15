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
	if (os_type != os_android) {
		volAlpha = ApproachFade(volAlpha,0.4+0.3*((point_in_rectangle(mouse_x,mouse_y,xMin+8,yMax-80,xMin+28,yMax-12) and !MOBILE) or volClick),0.2,0.8);
		if(point_in_rectangle(mouse_x,mouse_y,xMin+12,yMax-80,xMin+32,yMax-12) && mouse_check_button_pressed(mb_left)) volClick = true;
		else if(!mouse_check_button(mb_left)) volClick = false;
		if(volClick) {
			var _newVol = round(median(0,1,1-(mouse_y-yMax+74)/56)*10)/10;
			if vol != _newVol {
				vol = _newVol;
				audio_sound_gain(mMusic,vol,0);
				ini_open("score.ini");
				ini_write_real("settings","bgm",vol);
				ini_close();
			}
		}
	} else if global.hardMode == -1 {
		if(point_in_rectangle(mouse_x,mouse_y,xMax-72-guiXRight,yMax-72-oGUI.guiYBottom,xMax-8-guiXRight,yMax-8-oGUI.guiYBottom) and mouse_check_button(mb_left)) {
			settingsAlpha = ApproachFade(settingsAlpha,1,0.1,0.8);
			if(mouse_check_button_pressed(mb_left)) {
				settingsMenu = !settingsMenu;
				menuAllow = [0,0];
			}
		} else settingsAlpha = ApproachFade(settingsAlpha,0,0.1,0.8);
	}
	
	settingsMenuAlpha = ApproachFade(settingsMenuAlpha,settingsMenu,0.2,0.8);
	
	if settingsMenuAlpha != 0 {
		BGMSlider.step();
		LeaderboardButton.step();
		AchievementButton.step();
		PrivacyPolicyButton.step();
	}
	
	if(titleAlpha == 0 && !instance_exists(oShapeGet)) {
		title = false;
		newrecord = false;
		menuFadeOut = false;
		instance_create_layer(room_width/2,yMax+64,"Player",oPlayer);
		oGUI.alarm[0] = 15;
		audio_play_sound(snReady,1,false);
	}
	if(keyboard_check_pressed(vk_backspace) and MOBILE and os_browser == browser_not_a_browser) {
		if settingsMenu settingsMenu = false
		else game_end();
	}
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
	menuAllow = [0,0];
	tempStop = false;

	oGUI.alarm[0] = -1;
	oGUI.alarm[1] = -1;

	oGUI.start = 8;
	start = false;

	alarm[1] = -1;
	alarm[2] = -1;
	alarm[4] = -1;
}

if(point_in_rectangle(mouse_x,mouse_y,xMin+8+guiXLeft,yMax-40-32*MOBILE-oGUI.guiYBottom,xMin+40+32*MOBILE+guiXLeft,yMax-8-oGUI.guiYBottom)) {
	backAlpha = ApproachFade(backAlpha,!MOBILE or mouse_check_button(mb_left),0.1,0.8);
	if(mouse_check_button_pressed(mb_left)) backToMenu();
} else backAlpha = ApproachFade(backAlpha,0,0.1,0.8);

if(keyboard_check_pressed(vk_backspace) and MOBILE) backToMenu();
	
if(keyboard_lastkey != -1 and os_type != os_android) {
	if(keyboard_lastkey == secretCode[codeNum]) {
		codeNum++;
		if(array_length(secretCode) == codeNum) {
			codeActivated = !codeActivated;
			codeNum = 0;
		}
	} else codeNum = 0;	
	keyboard_lastkey = -1;
}
