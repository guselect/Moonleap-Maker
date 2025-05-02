drawinfo = point_in_rectangle(oCamera.x + 160, oCamera.y + 90, x, y, x + sprite_width, y + sprite_height);

if instance_exists(oPauseMenu) {
	drawinfo = false;
}

if drawinfo {
	bright = approach(bright, 3, 0.25);
}

if not drawinfo and bright != 0 {
	bright = approach(bright, 0, 0.25);
}
