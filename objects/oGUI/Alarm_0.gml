start--;
global.lives = min(6,global.lives+1);
if(start != 0) alarm[0] = 15;
else {
	oPlayer.locked = false;
	oGlobalController.alarm[1] = 60;
}
