/// @desc

if(percent >= 1) {
	if(correct and instance_exists(oPlayer)) {
		with(instance_create_depth(x,y-20,depth,oScore)) amount = "+"+string(other.points);
		if os_type == os_android and global.score < 10000 and global.score + points >= 2000 and (global.score + points) % 1000 < global.score % 1000 {
			GooglePlayServices_Achievements_Unlock(global.achievementID[global.hardMode][(global.score div 1000)-1]);
		}
		global.score += points;
	} else if(correct == -1) oGlobalController.tempStop = false;
	instance_destroy();
}