lockPercent = ApproachFade(lockPercent,locked,0.1,0.8);

damage = Approach(damage,0,0.01);

if(oGUI.start != 0) {
	x = room_width/2;
	y = lerp(room_height+50,Wave(lock[1]-2,lock[1]+2,0.5,0),lockPercent);
} else if(global.lives > 0) {
	if(!locked and mouse_check_button_pressed(mb_left)) {
		lock = [x,y-Wave(-2,2,0.5,0)];
		lockPercent = 1;
	}
	
	x = lerp(mouse_x,lock[0],lockPercent);
	y = lerp(Wave(mouse_y-2,mouse_y+2,0.5,0),Wave(lock[1]-2,lock[1]+2,0.5,0),lockPercent);
}
else if(y < room_height+64) {
	vsp += 0.3;
	y += vsp;
	
	if(y >= room_height+64) {
		audio_play_sound(snGameOver,1,false);
		oGUI.alarm[1] = 30;
		oGUI.start = 6;
		global.expandSpeed = 0.005;
		if(OPERA) {
			try gxc_challenge_submit_score(global.score,undefined,{challengeId: global.challengeID[global.hardMode]});
			catch(_error) show_debug_message(_error);
		}
		if(global.score > global.hiScore[global.hardMode]) {
			global.hiScore[global.hardMode] = global.score;
			if(!OPERA) {
				var _mode = ["normal","hard"];
				ini_open("score.ini");
				ini_write_real("score",_mode[global.hardMode],global.score);
				ini_close();
			}
			oGlobalController.newrecord = true;
		}
	}
}

if(alarm[0] <= 0) alarm[0] = 2;

if(blink > 0 and alarm[1] <= 0) alarm[1] = 5;
