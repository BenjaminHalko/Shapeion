draw_set_font(fontGui);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

draw_text(12,12,"SCORE\n  "+string_replace_all(string_format(global.score,4,0)," ","0"));
draw_set_halign(fa_center);
draw_text(room_width/2,12,"HIGH SCORE\n"+string_replace_all(string_format(global.hiScore,5,0)," ","0"));
for(var i = 0; i < 3; i++) {
	draw_sprite_ext(sLife,global.lives > i,room_width-34-i*50,28,scale[i]*4,scale[i]*4,0,c_white,1);
	scale[i] = Approach(scale[i],1,0.01);
}
