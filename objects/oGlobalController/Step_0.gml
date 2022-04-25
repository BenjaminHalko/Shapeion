if(os_browser != browser_not_a_browser) and (browser_width != width || browser_height != height)
{
	width = browser_width;
	height = browser_height;
	scale_canvas(960,540,width,height);
	
}
if(title) {
	if(global.hardMode != -1) startPercent = ApproachFade(startPercent,1,0.2,0.8);
	if(alarm[3] <= 0 and startPercent == 0) alarm[3] = room_speed*5;
	if(menuFadeOut) titleAlpha = ApproachFade(titleAlpha,0,0.1,0.8);
	if(titleAlpha == 0 && !instance_exists(oShapeGet)) {
		title = false;
		newrecord = false;
		menuFadeOut = false;
		instance_create_layer(room_width/2,room_height+64,"Player",oPlayer);
		oGUI.alarm[0] = 15;
	}
} else if(!instance_exists(oWall) && global.lives > 0 && start && !tempStop) instance_create_layer(0,0,"Wall",oWall);

global.expandSpeed = 0.001+0.0001*global.score/100+0.006*global.hardMode;
