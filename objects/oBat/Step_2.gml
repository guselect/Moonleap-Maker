scr_moving_plat()

if instance_exists(oPauseMenu) {
	exit;
}

if change and hsp == 0 {
	xx += 16 * dir;
	
	change = false;
}