lockPercent = ApproachFade(lockPercent,locked,0.1,0.8);

x = lerp(mouse_x,lock[0],lockPercent);
y = lerp(Wave(mouse_y-2,mouse_y+2,1.5,0),Wave(lock[1]-2,lock[1]+2,0.5,0),lockPercent);

if(alarm[0] <= 0) alarm[0] = 2;

if(blink > 0 and alarm[1] <= 0) alarm[1] = 5;
