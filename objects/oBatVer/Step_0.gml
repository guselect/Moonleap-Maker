if x < 0 {
	x += room_width;
}

if x > room_width {
	x -= room_width;
}

if y < 0 {
	y += room_width;
	yy += room_width - 4;
}

if y > room_height {
	y -= room_height;
	yy -= room_height - 4;
}

if dir == 1 {
	if y < yy {
		vsp += 0.1;
	} else {
		vsp = 0;
	}
	sprite_index = sBatDown;
}

if dir == -1 {
	if y > yy {
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

if instance_exists(oMush) {
	if place_meeting(x, y + sign(vsp), oMush) {
		dir *= -1;
		scr_change();
		if not audio_is_playing_any([snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04]) {
			var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
			audio_play_sfx(sfxcogu, false, -16, 2)
		}
	}
}

image_speed = vsp == 0 ? 1 : 3;
