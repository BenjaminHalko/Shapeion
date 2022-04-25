draw_set_font(fontGui);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);


if(oGlobalController.title) {
	draw_text(room_width/3,lerp(12,-32,1-oGlobalController.titleAlpha),"NORMAL HI-SCORE\n  "+string_replace_all(string_format(global.hiScore[0],5,0)," ","0"));
	draw_text(room_width/3*2,lerp(12,-32,1-oGlobalController.titleAlpha),"HARD HI-SCORE\n"+string_replace_all(string_format(global.hiScore[1],5,0)," ","0"));
}

if(global.hardMode != -1) {
	draw_set_halign(fa_left);
	draw_text(64,lerp(12,-32,oGlobalController.titleAlpha),"SCORE\n  "+string_replace_all(string_format(global.score,4,0)," ","0"));
	draw_set_halign(fa_center);	
	draw_text(room_width/2,lerp(12,-32,oGlobalController.titleAlpha),"HIGH SCORE\n"+string_replace_all(string_format(global.hiScore[global.hardMode],5,0)," ","0"));
	draw_set_valign(fa_bottom);
	if(instance_exists(oWall)) {
		draw_set_alpha(1-oWall.z);
		draw_text(room_width/2,room_height-12,shapeText);
		draw_set_alpha(1);
	}
	for(var i = 0; i < 6; i++) {
		scale[i] = ApproachFade(scale[i],lerp(0.63,1,global.lives > i),0.1,0.8);
		draw_sprite_ext(sLife,global.lives > i,room_width-76-i*32,lerp(24,-48,oGlobalController.titleAlpha),scale[i],scale[i],0,c_white,1);
	}

	draw_set_valign(fa_center);
	if(start % 2) {
		if(!oGlobalController.start) draw_text(room_width/2,room_height/2,"READY");
		else draw_text(room_width/2,room_height/2,"GAME OVER");
	}
}
