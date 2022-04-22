draw_set_color(c_white);
draw_set_alpha(image_alpha);
draw_line_shadow(shapeArray);
draw_set_alpha(1)

image_alpha -= 0.1;
if(image_alpha <= 0) instance_destroy();
