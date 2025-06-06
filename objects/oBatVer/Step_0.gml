if x < 0 {
	x += room_width;
}

if x > room_width {
	x -= room_width;
}

if y < 0 {
	y += room_height;
	yy += room_height - 4;
}

if y > room_height {
	y -= room_height;
	yy -= room_height - 4;
}

if dir == 1 {
	if y < yy and not has_collided(0, sign(dir), true, [oPermaSpike], [oSnail, oSnailNight, oSnailGray]) {
		vsp += 0.1;
	} else {
		vsp = 0;
	}
	sprite_index = sBatDown;
}

if dir == -1 {
	if y > yy and not has_collided(0, sign(dir), true, [oPermaSpike], [oSnail, oSnailNight, oSnailGray]) {
		vsp -= 0.1;
	} else {
		vsp = 0;
	}
	sprite_index = sBatUp;
}

vsp = clamp(vsp, -1, 1);

if vsp == 0 and has_collided(0, sign(dir), true, [oPermaSpike], [oSnail, oSnailNight, oSnailGray]) {
	dir *= -1;
}

check_mushroom_collision();

image_speed = vsp == 0 ? 1 : 3;
