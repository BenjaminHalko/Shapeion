lockPercent = ApproachFade(lockPercent,locked,0.1,0.8);

damage = Approach(damage,0,0.01);

if(oGUI.start != 0) {
	x = room_width/2;
	y = lerp(room_height+50,Wave(lock[1]-2,lock[1]+2,0.5,0),lockPercent);
} else if(global.lives > 0) {
	x = lerp(mouse_x,lock[0],lockPercent);
	y = lerp(Wave(mouse_y-2,mouse_y+2,0.5,0),Wave(lock[1]-2,lock[1]+2,0.5,0),lockPercent);
}
else if(y < room_height+64) {
	vsp += 0.3;
	y += vsp;
	
	if(y >= room_height+64) {
		oGUI.alarm[1] = 30;
		oGUI.start = 6;
		global.expandSpeed = 0.005;
		if(global.score > global.hiScore) {
			global.hiScore = global.score;
			var _file = file_text_open_write("score");
			file_text_write_real(_file,global.score);
			file_text_close(_file);
		}
	}
}

if(alarm[0] <= 0) alarm[0] = 2;

if(blink > 0 and alarm[1] <= 0) alarm[1] = 5;
