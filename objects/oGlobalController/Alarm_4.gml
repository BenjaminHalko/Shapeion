/// @desc

menuFadeOut = true;
with(instance_create_depth(room_width/2,room_height/4*3+20+min(0.8,guiRatio-1)*120,-10000,oShapeGet)) {
	correct = true;
	num = 4+global.hardMode*2;
	size = min(140,80*guiRatio);
	angle = 90;
}
