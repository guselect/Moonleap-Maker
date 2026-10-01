if instance_exists(oPauseUI) then exit;

apply_movement_collision(false, true);

if change and vsp == 0 {
	yy += 16 * dir;
	
	change = false;
}