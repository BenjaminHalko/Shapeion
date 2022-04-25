shapes = [];

size = 100-20*global.hardMode;

var _shapeArray = [3,4,6,5,8,7,10,9];
var _soundArray = [snTriangle,snSquare,snHexagon,snPentagon,snOctagon,snSeptagon,snDecagon,snNonagon];
var _shapeTextArray = ["TRIANGLE","SQUARE","HEXAGON","PENTAGON","OCTAGON","SEPTAGON","DECAGON","NONAGON"];

repeat(2+(global.score >= 1000)+(global.score >= 3000)+(global.score >= 5000)+global.hardMode) {
	var _x, _y,_shape, _index;
	_x = -1;
	while(_x == -1) {
		_x = irandom_range(size,room_width-size);
		_y = irandom_range(size,room_height-size);
		
		
		_index = irandom(3+(global.score >= 2000)+(global.score >= 4000)+global.hardMode*2);
		var _shape = _shapeArray[_index];
		if(array_length(shapes) == 0) {
			audio_play_sound(_soundArray[_index],1,false);
			oGUI.shapeText = _shapeTextArray[_index];
		}
		
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

spd = max(global.expandSpeed,0.01);

finalZ = -0.1;

fast = false;
