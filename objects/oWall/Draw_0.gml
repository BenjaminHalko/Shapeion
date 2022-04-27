var _fadeTime = 0.05;

var _pointIn = -1;

if(!surface_exists(surface)) {
	surface = surface_create(room_width,room_height);
	surface_set_target(surface);
	draw_set_color(c_white);
	draw_rectangle(0,0,room_width,room_height,false);
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

draw_surface_ext(surface,room_width*max(0,1-z)/2,room_height*max(0,1-z)/2,min(1,z),min(1,z),0,merge_color(c_black,oGlobalController.currentColor,min(1,z*2)),min(1,(_fadeTime-max(0,z-1))/_fadeTime));

draw_set_alpha(min(1,(_fadeTime-max(0,z-1))/_fadeTime));
for(var j = 0; j < array_length(shapes); j++) {
	if(_pointIn == -1) {
		for(var i = 0; i < shapes[j].num; i++) {
			if(holding() and point_in_triangle(mouse_x,mouse_y,shapes[j].x,shapes[j].y,shapes[j].x+lengthdir_x(size,360/shapes[j].num*i+shapes[j].angle),shapes[j].y+lengthdir_y(size,360/shapes[j].num*i+shapes[j].angle),shapes[j].x+lengthdir_x(size,360/shapes[j].num*(i+1)+shapes[j].angle),shapes[j].y+lengthdir_y(size,360/shapes[j].num*(i+1)+shapes[j].angle))) {
				_pointIn = j;
				break;
			}
		}
	}
	
	if(finalZ == 1) shapes[j].percent = ApproachFade(shapes[j].percent,_pointIn == j,0.04,0.7);
	
	var _shapeArray = [];
	var _shapeArrayCol = [];

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
		
		//draw_set_color(c_grey);
		//draw_line(_xFinal-1,_yFinal-1,room_width*(1-min(1,z))/2+_x*min(1,z)-1,room_height*(1-min(1,z))/2+_y*min(1,z)-1);
		
		array_push(_shapeArray,[_xFinal,_yFinal,_x2Final,_y2Final]);
		
		if(shapes[j].percent > 1/shapes[j].num*(shapes[j].num-i-1)) {
			var _percent = min(1,shapes[j].percent*shapes[j].num-(shapes[j].num-i-1));
			array_push(_shapeArrayCol,[_x2Final,_y2Final,lerp(_x2Final,_xFinal,_percent),lerp(_y2Final,_yFinal,_percent)]);
		}		
	}
	
	draw_set_color(c_white);
	draw_line_shadow(_shapeArray);
	setColorOpposite();
	draw_line_shadow(_shapeArrayCol,4);
	/*
	for(var i = 0; i < array_length(_shapeArrayCol); i++) {
		draw_line_width(_shapeArrayCol[i][0],_shapeArrayCol[i][1],_shapeArrayCol[i][2],_shapeArrayCol[i][3],4);
	}
	*/
	
	if(shapes[j].percent == 1) {
		fast = true;
		oPlayer.lock = [shapes[j].x,shapes[j].y];
		oPlayer.locked = true;
		shapeChoosen = j;
	}
}
draw_set_alpha(1);

if(_pointIn != 0 and finalZ == 1) points = max(points-global.expandSpeed*300,50);	

if(z >= 1 && depth != -10000) {
	depth = -10000;
	
	if(shapeChoosen == -1) shapeChoosen = _pointIn;
	
	if(shapeChoosen != -1) {
		with(instance_create_depth(shapes[shapeChoosen].x,shapes[shapeChoosen].y,depth,oShapeGet)) {
			num = other.shapes[other.shapeChoosen].num;
			angle = other.shapes[other.shapeChoosen].angle;
			size = other.size;
			correct = other.shapeChoosen == 0;
			points = round(other.points);
		}
	} else {
		for(var i = 1; i < array_length(shapes); i++) {
			with(instance_create_depth(shapes[i].x,shapes[i].y,depth,oShapeGet)) {
				num = other.shapes[i].num;
				angle = other.shapes[i].angle;
				size = other.size;
				correct = false;
			}	
		}
	}
	if(shapeChoosen != 0) {
		with(instance_create_depth(shapes[0].x,shapes[0].y,depth,oShapeGet)) {
			num = other.shapes[0].num;
			angle = other.shapes[0].angle;
			size = other.size;
			correct = -1;
		}
		oGlobalController.tempStop = true;
		oPlayer.damage = 1;
		global.lives--;
		if(global.lives > 0) oPlayer.blink = 14;
	}
}

if(z >= 1+_fadeTime) {
	instance_destroy();
	oPlayer.locked = false;
	oGlobalController.lastColor = oGlobalController.currentColor;
	oGlobalController.colorPercent = 0;
	if(global.lives <= 0) oGlobalController.currentColor = c_grey;
	else oGlobalController.currentColor = make_color_hsv(irandom(255),255,255);
}
