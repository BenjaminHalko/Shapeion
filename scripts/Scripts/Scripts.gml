function Approach(a, b, amount) {
	if (a < b)
	{
	    a += amount;
	    if (a > b)
	        return b;
	}
	else
	{
	    a -= amount;
	    if (a < b)
	        return b;
	}
	return a;
}

function ApproachFade(Value,Target,MaxSpd,Ease) {
	Value += median(-MaxSpd,MaxSpd,(1-Ease)*(Target-Value));
	return Value;
}

function ApproachCircleEase(Value,Target,MaxSpd,Ease) {
	Value += median(-MaxSpd,MaxSpd,(1-Ease)*angle_difference(Target,Value));
	return Value
}

function Wave(_from, _to, _duration, _offset) {
	a4 = (_to - _from) * 0.5;
	return _from + a4 + sin((((current_time * 0.001) + _duration * _offset) / _duration) * (pi*2)) * a4;
}

function scale_canvas(_bw,_bh,_cw,_ch) {
var _aspect = (_bw / _bh);

if ((_cw / _aspect) > _ch)
    {
    window_set_size((_ch *_aspect), _ch);
    }
else
    {
    window_set_size(_cw, (_cw / _aspect));

    }
	window_center();
}

function draw_line_shadow(_array,_width=2,_col=c_black) {
	if(_col != c_black) 	for(var i = 0; i < array_length(_array); i++) draw_line_width_color(_array[i][0],_array[i][1],_array[i][2],_array[i][3],_width+4,_col,_col);
	for(var i = 0; i < array_length(_array); i++) draw_line_width_color(_array[i][0],_array[i][1],_array[i][2],_array[i][3],_width+2,c_black,c_black);
	for(var i = 0; i < array_length(_array); i++) draw_line_width(_array[i][0],_array[i][1],_array[i][2],_array[i][3],_width);
}

function setColorOpposite() {
	var _col = color_get_hue(oGlobalController.currentColor)+128;
	if(_col > 255) _col -= 255;
	draw_set_color(make_color_hsv(_col,255,255));
}
