if y > room_height {
	y -= 180;
	yy -= 176;
}

if x > room_width {
	x -= 320;
}

if y < 0 {
	y += 180;
	yy += 176;
}

if x < 0 {
	x += 320;
}

change_dir_on_collide();

if instance_exists(oMush) {
	if place_meeting(x, y + sign(vsp), oMush) {
		dir *= -1;
		scr_change();
		if not (audio_is_playing(snd_cogumelo_01)
			or audio_is_playing(snd_cogumelo_02) 
			or audio_is_playing(snd_cogumelo_03)
			or audio_is_playing(snd_cogumelo_04)
		) {
			var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
			audio_play_sfx(sfxcogu,false,-16,2)
		}
	}
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
image_speed = vsp == 0 ? 1 : 3;