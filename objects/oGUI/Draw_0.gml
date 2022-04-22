draw_set_font(fontGui);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

draw_text(12,12,"SCORE\n  "+string_replace_all(string_format(global.score,4,0)," ","0"));
draw_set_halign(fa_center);
draw_text(room_width/2,12,"HIGH SCORE\n"+string_replace_all(string_format(global.hiScore,5,0)," ","0"));
for(var i = 0; i < 6; i++) {
	scale[i] = ApproachFade(scale[i],(global.lives > i)*1.5+2.5,0.1,0.8);
	draw_sprite_ext(sLife,global.lives > i,room_width-34-i*50,28,scale[i],scale[i],0,c_white,1);
}

draw_set_valign(fa_center);
if(start % 2) {
	if(!oGlobalController.start) draw_text(room_width/2,room_height/2,"READY");
	else draw_text(room_width/2,room_height/2,"GAME OVER");
}
