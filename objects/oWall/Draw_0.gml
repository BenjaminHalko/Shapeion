var _fadeTime = 0.05;

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
	surface_reset_target();
}

if(z >= 1) z += 0.003;
else z = min(1,z+spd);

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
	for(var i = 0; i < shapes[j].num; i++) {
		var _x = shapes[j].x+lengthdir_x(size,360/shapes[j].num*i+shapes[j].angle);
		var _y = shapes[j].y+lengthdir_y(size,360/shapes[j].num*i+shapes[j].angle);
		
		var _x2 = shapes[j].x+lengthdir_x(size,360/shapes[j].num*(i+1)+shapes[j].angle);
		var _y2 = shapes[j].y+lengthdir_y(size,360/shapes[j].num*(i+1)+shapes[j].angle);
		
		var _z = lerp(z,1,max(0,finalZ));
		
		var _xFinal = room_width*(1-_z)/2+_x*_z;
		var _yFinal = room_height*(1-_z)/2+_y*_z;
		
		var _x2Final = room_width*(1-_z)/2+_x2*_z;
		var _y2Final = room_height*(1-_z)/2+_y2*_z;
		
		draw_set_color(c_grey);
		if(point_in_rectangle(_x-1,_y-1,0,0,room_width,room_height))
			draw_line(_xFinal-1,_yFinal-1,room_width*(1-min(1,z))/2+_x*min(1,z)-1,room_height*(1-min(1,z))/2+_y*min(1,z)-1);
		draw_set_color(c_white);
		if(j == 0) draw_set_color(c_aqua);
		draw_line_width(_xFinal,_yFinal,_x2Final,_y2Final,2);
		
		if(finalZ == 1) shapes[j].percent = ApproachFade(shapes[j].percent,_pointIn == j,0.01,0.8);
		
		draw_set_color(c_lime);
		if(shapes[j].percent > 1/shapes[j].num*(shapes[j].num-i-1)) {
			var _percent = min(1,shapes[j].percent*shapes[j].num-(shapes[j].num-i-1));
			draw_line_width(_x2Final,_y2Final,lerp(_x2Final,_xFinal,_percent),lerp(_y2Final,_yFinal,_percent),2);
		}
		
		if(shapes[j].percent == 1) {
			fast = true;
			oPlayer.lock = [shapes[j].x,shapes[j].y];
			oPlayer.locked = true;
		}
	}
}
draw_set_alpha(1);

if(z+spd >= 1) 

if(z+spd >= 1 && z < 1) {
	depth = -10000;
	
	if(_pointIn != -1) {
		with(instance_create_depth(shapes[_pointIn].x,shapes[_pointIn].y,depth,oShapeGet)) {
			num = other.shapes[_pointIn].num;
			angle = other.shapes[_pointIn].angle;
			size = other.size;
			correct = _pointIn == 0;
		}
	}
	if(_pointIn != 0) {
		oPlayer.blink = 20;	
		global.lives--;
		if(global.lives >= 0) oGUI.score[global.lives] = 8;
	}
}

if(z >= 1+_fadeTime) {
	instance_destroy();
	oPlayer.locked = false;
	oGlobalController.lastColor = oGlobalController.currentColor;
	oGlobalController.currentColor = make_color_hsv(irandom(255),255,255);
	oGlobalController.colorPercent = 0;
	instance_create_depth(0,0,layer_get_depth(layer_get_id("Wall")),oWall);
}
