start--;
if(start != 0) alarm[1] = 30;
else {
	start = 8;
	oPlayer.locked = true;
	oGlobalController.start = false;
	global.score = 0;
	oPlayer.vsp = -10;
	alarm[0] = 30;
	oPlayer.lock = [room_width/2,room_height/2+64];
	oGlobalController.lastColor = oGlobalController.currentColor;
	oGlobalController.colorPercent = 0;
	oGlobalController.currentColor = make_color_hsv(irandom(255),255,255);
}
