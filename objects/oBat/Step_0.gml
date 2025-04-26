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

change_dir_on_collide();

if instance_exists(oMush) {
	if place_meeting(x + sign(hsp), y, oMush) {
		dir *= -1;
		scr_change();
		if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
	}
}

if dir == 1 {
	if x < xx {
		hsp += 0.1;
	} else {
		hsp = 0;
	}
	sprite_index = sBat;
}

if dir == -1 {
	if x > xx {
		hsp -= 0.1;
	} else {
		hsp = 0;
	}
	sprite_index = sBatInv;
}

hsp = clamp(hsp, -1, 1);
image_speed = x == xx ? 1 : 3;