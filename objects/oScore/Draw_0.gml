draw_set_font(fontGui);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

draw_set_alpha(image_alpha);
draw_text(x,y-floor((1-image_alpha)*3),amount)
draw_set_alpha(1);