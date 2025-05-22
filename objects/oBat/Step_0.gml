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

check_mushroom_collision();

image_speed = x == xx ? 1 : 3;