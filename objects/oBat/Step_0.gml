if y > room_height {
	y -= room_height;
}
	
if x > room_width {
	x -= room_width;
	xx -= room_width;
}
	
if y < 0 {
	y += room_height;
}
	
if x < 0 {
	x += room_width;
	xx += room_width;
}

if dir == 1 {
	if x < xx and not has_collided(sign(dir), 0) {
		hsp += 0.1;
	} else {
		hsp = 0;
	}
	sprite_index = sBat;
}

if dir == -1 {
	if x > xx and not has_collided(sign(dir), 0) {
		hsp -= 0.1;
	} else {
		hsp = 0;
	}
	sprite_index = sBatInv;
}

hsp = clamp(hsp, -1, 1);

if hsp == 0 and has_collided(sign(dir), 0, true, [oPermaSpike]) {
	dir *= -1;
}

if instance_exists(oMush) {
	if (place_meeting(x + 1, y, oMush) and dir == 1)
	or (place_meeting(x - 1, y, oMush) and dir == -1){
		dir *= -1;
		scr_change();
		play_mushroom_sound();
	}
}

image_speed = x == xx ? 1 : 3;