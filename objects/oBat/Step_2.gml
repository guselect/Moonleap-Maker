if instance_exists(oPauseUI) then exit;

apply_movement_collision(false, true);

if change and hsp == 0 {
	xx += 16 * dir;
	
	change = false;
}