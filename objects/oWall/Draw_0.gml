var _fadeTime = 0.05;
var _col = [c_white,c_lime];

var _pointIn = -1;

if(!surface_exists(surface)) {
	
	surface = surface_create(room_width,room_height);
	surface_set_target(surface);
	draw_sprite_ext(sWall,0,0,0,room_width/8,room_height/8,0,c_white,1);
	gpu_set_blendmode(bm_subtract);
	draw_set_color(c_white);
	draw_primitive_begin(pr_trianglelist);
	for(var j = 0; j < array_length(shapes); j++) {
		for(var i = 0; i < shapes[j].num; i++) {
			draw_vertex(shapes[j].x,shapes[j].y);
			draw_vertex(shapes[j].x+lengthdir_x(size,360/shapes[j].num*i+shapes[j].angle),shapes[j].y+lengthdir_y(size,360/shapes[j].num*i+shapes[j].angle));
			draw_vertex(shapes[j].x+lengthdir_x(size,360/shapes[j].num*(i+1)+shapes[j].angle),shapes[j].y+lengthdir_y(size,360/shapes[j].num*(i+1)+shapes[j].angle));
		}
	}
	draw_primitive_end();
	gpu_set_blendmode(bm_normal);
	draw_primitive_begin(pr_linelist);
	for(var j = 0; j < array_length(shapes); j++) {
		for(var i = 0; i < shapes[j].num; i++) {
			draw_vertex(shapes[j].x+lengthdir_x(size,360/shapes[j].num*i+shapes[j].angle),shapes[j].y+lengthdir_y(size,360/shapes[j].num*i+shapes[j].angle));
			draw_vertex(shapes[j].x+lengthdir_x(size,360/shapes[j].num*(i+1)+shapes[j].angle),shapes[j].y+lengthdir_y(size,360/shapes[j].num*(i+1)+shapes[j].angle));
		}
	}
	draw_primitive_end();
	surface_reset_target();
}

z += global.expandSpeed;

draw_surface_ext(surface,room_width*max(0,1-z)/2,room_height*max(0,1-z)/2,min(1,z),min(1,z),0,merge_color(c_black,c_white,min(1,z*2)),min(1,(_fadeTime-max(0,z-1))/_fadeTime));

draw_set_alpha(min(1,(_fadeTime-max(0,z-1))/_fadeTime));
for(var j = 0; j < array_length(shapes); j++) {
	if(_pointIn == -1) {
		for(var i = 0; i < shapes[j].num; i++) {
			if(point_in_triangle(oPlayer.x,oPlayer.y,shapes[j].x,shapes[j].y,shapes[j].x+lengthdir_x(size,360/shapes[j].num*i+shapes[j].angle),shapes[j].y+lengthdir_y(size,360/shapes[j].num*i+shapes[j].angle),shapes[j].x+lengthdir_x(size,360/shapes[j].num*(i+1)+shapes[j].angle),shapes[j].y+lengthdir_y(size,360/shapes[j].num*(i+1)+shapes[j].angle))) {
				_pointIn = j;
				break;
			}
		}
	}
	draw_primitive_begin(pr_linelist);
	for(var i = 0; i < shapes[j].num; i++) {
		var _x = shapes[j].x+lengthdir_x(size,360/shapes[j].num*i+shapes[j].angle);
		var _y = shapes[j].y+lengthdir_y(size,360/shapes[j].num*i+shapes[j].angle);
		var _z = 1;
		if(num != 0) _z = min(1,instance_find(oWall,num-1).z);
		draw_set_color(c_grey);
		draw_line(room_width*(1-_z)/2+_x*_z-1,room_height*(1-_z)/2+_y*_z-1,room_width*(1-min(1,z))/2+_x*min(1,z)-1,room_height*(1-min(1,z))/2+_y*min(1,z)-1);
		draw_set_color(_col[_pointIn == j]);
		if(num == 0) {
			draw_vertex(shapes[j].x+lengthdir_x(size,360/shapes[j].num*i+shapes[j].angle),shapes[j].y+lengthdir_y(size,360/shapes[j].num*i+shapes[j].angle));
			draw_vertex(shapes[j].x+lengthdir_x(size,360/shapes[j].num*(i+1)+shapes[j].angle),shapes[j].y+lengthdir_y(size,360/shapes[j].num*(i+1)+shapes[j].angle));
		}
	}
	draw_primitive_end();
}
draw_set_alpha(1);

if(z+global.expandSpeed >= 1 && z < 1 && _pointIn != -1) {
	//with(instance_create_layer(shapes[_pointIn].x,shapes[_pointIn].y,layer,oShapeGet)
}

if(z >= 1+_fadeTime) {
	with(oWall) num--;
	instance_destroy();
}
