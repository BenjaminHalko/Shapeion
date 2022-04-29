/// @desc

if(correct) {
	var _size = size*animcurve_channel_evaluate(curveCorrect,percent);
	var _angle = min(1,animcurve_channel_evaluate(curveCorrect,percent))*180+angle+180;

	if(instance_exists(oPlayer)) {
		draw_set_color(c_white);
		x = lerp(xstart,oPlayer.x,1-min(1,animcurve_channel_evaluate(curveCorrect,percent)));
		y = lerp(ystart,oPlayer.y,1-min(1,animcurve_channel_evaluate(curveCorrect,percent)));
	} else setColorOpposite();
	
	var _shapeArray = [];
	for(var i = 0; i < num; i++) {
		array_push(_shapeArray,[x+lengthdir_x(_size,360/num*i+_angle),y+lengthdir_y(_size,360/num*i+_angle),
		x+lengthdir_x(_size,360/num*(i+1)+_angle),y+lengthdir_y(_size,360/num*(i+1)+_angle)]);
	}
	draw_line_shadow(_shapeArray);
	with(instance_create_depth(x,y,layer,oShapeAfter)) shapeArray = _shapeArray;
	
	percent += 0.03;
}
else if(correct == -1) {
	draw_set_color(c_white);
	var _size = lerp(size,200,percentMove)*min(1,animcurve_channel_evaluate(curveCorrect,percent));
	var _angle = lerp(angle,0,percentMove)+min(1,animcurve_channel_evaluate(curveCorrect,percent))*90;
	x = lerp(xstart,room_width/2,percentMove);
	y = lerp(ystart,room_height/2,percentMove);
	var _shapeArray = [];
	for(var i = 0; i < num; i++) {
		array_push(_shapeArray,[x+lengthdir_x(_size,360/num*i+_angle),y+lengthdir_y(_size,360/num*i+_angle),
		x+lengthdir_x(_size,360/num*(i+1)+_angle),y+lengthdir_y(_size,360/num*(i+1)+_angle)]);
	}
	draw_line_shadow(_shapeArray,2+(blink%2)*3,oGlobalController.currentColor);
	
	if(alarm[0] <= 0 && blink > 0) alarm[0] = 5;
	if(blink == 0) percent += 0.05;
	percentMove = ApproachFade(percentMove,1,0.05,0.8);
}
else {
	draw_set_color(merge_color(c_white,c_black,percent));
	var _size = size+200*percent;
	var _size2 = point_distance(size,0,lengthdir_x(size,360/num),lengthdir_y(size,360/num))/2*animcurve_channel_evaluate(curveWrong,percent);

	var _shapeArray = [];
	for(var i = 0; i < num; i++) {
		var _x1 = x+lengthdir_x(_size,360/num*i+angle);
		var _y1 = y+lengthdir_y(_size,360/num*i+angle);
		
		var _x2 = x+lengthdir_x(_size,360/num*(i+1)+angle);
		var _y2 = y+lengthdir_y(_size,360/num*(i+1)+angle);
		
		var _x = lerp(_x1,_x2,0.5);
		var _y = lerp(_y1,_y2,0.5);
		var _dir = 360/num*(i+0.5)+angle+90+percent*30;
		
		array_push(_shapeArray,[_x-lengthdir_x(_size2,_dir),_y-lengthdir_y(_size2,_dir),
		_x+lengthdir_x(_size2,_dir),_y+lengthdir_y(_size2,_dir)]);
	}
	draw_line_shadow(_shapeArray);
	
	percent += 0.02;
}


if(percent >= 1) {
	if(correct and instance_exists(oPlayer)) {
		with(instance_create_depth(x,y-20,depth,oScore)) amount = "+"+string(other.points);
		global.score += points;
	} else if(correct == -1) oGlobalController.tempStop = false;
	instance_destroy();
}
