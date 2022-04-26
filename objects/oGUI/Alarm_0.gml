start--;
global.lives = min(MAXLIVES,global.lives+1);
if(start != 0) alarm[0] = 15;
else {
	oPlayer.locked = false;
	oGlobalController.alarm[1] = 60;
	audio_play_sound(snGo,1,false);
}
