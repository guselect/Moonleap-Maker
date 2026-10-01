if y > room_height then y -= room_height;
if y < 0 then y += room_height;
if x > room_width {
	x -= room_width;
	xx -= room_width;
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

hsp = clamp(hsp, -v_fly, v_fly);

if hsp == 0 and has_collided(sign(dir), 0, true, [oPermaSpike]) {
	dir *= -1;
}

check_mushroom_collision();

image_speed = x == xx ? 1 : 3;
