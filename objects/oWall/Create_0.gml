
shapes = [];

size = 100;

repeat(3) {
	var _x, _y;
	_x = -1;
	while(_x == -1) {
		_x = irandom_range(size,room_width-size);
		_y = irandom_range(size,room_height-size);
		var _shape = irandom_range(3,6);
		
		for(var i = 0; i < array_length(shapes); i++) {
			if(point_distance(_x,_y,shapes[i].x,shapes[i].y) <= size*2) or (shapes[i].num == _shape) {
				_x = -1;
				break;
			}
		}
	}
	
	array_push(shapes, {
		x: _x,
		y: _y,
		num: _shape,
		angle: random(360),
		percent: 0
	});
}

surface = noone;

z = 0;

spd = 0.02;

finalZ = -0.1;

fast = false;
