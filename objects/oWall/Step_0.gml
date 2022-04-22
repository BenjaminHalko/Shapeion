if(fast) spd = ApproachFade(spd,0.05,0.05,0.8);
else if(z > 0.1) spd = ApproachFade(spd,global.expandSpeed,0.05,0.8);

finalZ = ApproachFade(finalZ,1,0.05,0.6);
