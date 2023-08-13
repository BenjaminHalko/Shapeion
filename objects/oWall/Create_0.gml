shapes = [];

size = (120-20*global.hardMode)*sizeRatio;

var _shapeArray = [24,3,4,6,5,8,7];
var _soundArray = [snCircle,snTriangle,snSquare,snHexagon,snPentagon,snOctagon,snSeptagon];
var _shapeTextArray = ["CIRCLE","TRIANGLE","SQUARE","HEXAGON","PENTAGON","OCTAGON","SEPTAGON"];

var _shapeNum = -1;
var _x, _y,_shape, _index, _attempt;

while(array_length(shapes) < min(5,2+(global.score >= 1000)+(global.score >= 3000)+(global.score >= 5000)+global.hardMode)) {
	_x = -1;
	_attempt = 0;
	while(_x == -1) {
		_attempt++;
		if(_attempt > 100) {
			shapes = [];
		}
		_x = irandom_range(xMin+size,xMax-size);
		_y = irandom_range(yMin+size,yMax-size);
		
		_index = irandom(min(6,3+(global.score >= 500)+(global.score >= 2000)+(global.score >= 8000)+global.hardMode*2));
		_shape = _shapeArray[_index];
		if(array_length(shapes) == 0) _shapeNum = _index;
		
		if(point_distance(_x,_y,mouse_x,mouse_y) < size) _x = -1;
		else {
			for(var i = 0; i < array_length(shapes); i++) {
				if(point_distance(_x,_y,shapes[i].x,shapes[i].y) <= size*2) or (shapes[i].num == _shape) {
					_x = -1;
					break;
				}
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

audio_play_sound(_soundArray[_shapeNum],1,false);
oGUI.shapeText = _shapeTextArray[_shapeNum];

surface = noone;

z = 0;

spd = max(global.expandSpeed,0.01);

finalZ = -0.1;

fast = false;

points = 200;
shapeChoosen = -1;
