
shapes = [];

size = 50;

repeat(2) array_push(shapes, {
	x: irandom(room_width),
	y: irandom(room_height),
	num: irandom_range(3,5),
	angle: random(360),
});

surface = noone;

z = 0;

num = instance_number(oWall)-1;
