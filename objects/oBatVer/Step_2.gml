if instance_exists(oPauseMenu) then exit;

if change and vsp == 0 {
	yy += 16 * dir;
	
	change = false;
}

scr_moving_plat();