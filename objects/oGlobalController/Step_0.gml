if(browser_width != width || browser_height != height)
{
	width = browser_width;
	height = browser_height;
	scale_canvas(960,540,width,height);
	
}
if(title) {
	if(mouse_check_button_pressed(mb_left)) {
		title = false;
		instance_create_layer(room_width/2,room_height+64,"Player",oPlayer);
		oGUI.alarm[0] = 15;
	}
} else if(!instance_exists(oWall) && global.lives > 0 && start && !tempStop) instance_create_layer(0,0,"Wall",oWall);

global.expandSpeed = 0.001+0.0001*global.score/100;
