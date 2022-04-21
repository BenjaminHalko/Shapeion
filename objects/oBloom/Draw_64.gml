//if(!surface_exists(global.glowSurface)) exit;
shader_set(shdr_bloom);
shader_set_uniform_f(bloomIntensity, 1); //0 = off, 1 = a bit, 80 = extremely intense
//shader_set_uniform_f(bloomblurSize, ((window_mouse_get_x()-250)/1000)); // usually something like 1/512 (0.001)
shader_set_uniform_f(bloomblurSize, 1/1024);
draw_surface(application_surface, 0, 0);
shader_reset();

//surface_set_target(global.glowSurface);
//draw_clear_alpha(c_black,0);
//surface_reset_target();
