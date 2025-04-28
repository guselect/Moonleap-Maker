numb = approach(numb, 0, 1);

on_ground_var = has_collided(0, 1, true, [oPermaSpike]);

if not on_ground_var {
	vsp = min(vsp + grav, 3);
}

object_set_room_wrapping();

if night {
	sprite_index = idlesprite;
	image_index = 1;
} else {
	sprite_index = walksprite;
}

if ani > 0 {
	sprite_index = idlesprite;
	image_index = 0;
	ani -= 1;
}

if not night {
	if vsp == 0 
	and abs(image_xscale) == 1
	and (not has_collided(-(sprite_width / 2), 2, true, [oPermaSpike]) 
		or has_collided(-(image_xscale * 4), 0, true, [oPermaSpike])
	) {
		image_xscale *= -1;
	}

	hsp -= image_xscale * 0.075;
	hsp = clamp(hsp, -0.55, 0.55);
}

var nearmush = instance_place(x, y, oMush);
if nearmush != noone {
	if nearmush.image_angle == 0 and place_meeting(x, y, nearmush) and vsp >= 0 {
		y = nearmush.y;
		nearmush.image_speed = 1;
		vsp = -4;
			
		play_mushroom_sound();
		scr_change();
		shake_gamepad(0.4, 2);
		spawn_dust_particles();
	}

	if (nearmush.image_angle == -90 or nearmush.image_angle == 270)
	and place_meeting(x, y, nearmush) and image_xscale == 1 {
		nearmush.image_speed = 1;
		image_xscale = -1;
		hsp_plus = 2;
		hsp = 0.55;
		 	
		play_mushroom_sound();
		scr_change();
		shake_gamepad(0.4, 2);
		spawn_dust_particles();
	}
	
	if (nearmush.image_angle == -270 or nearmush.image_angle == 90)
	and place_meeting(x,y,nearmush) and image_xscale == 1 {
		nearmush.image_speed = 1;
		image_xscale = 1;
		hsp_plus = -2;
		hsp = -0.55;
			
		play_mushroom_sound();
		scr_change();
		shake_gamepad(0.4, 2);
		spawn_dust_particles();
	}
}

hsp_plus = approach(hsp_plus, 0, 0.1);

if hsp_plus > 0 {
	spawn_dust_particles();
}

sindex = sprite_index;
iindex = image_index;
xindex = image_xscale;

if not night and vsp == 0 {
	if is_stuck() {
		sprite_index = walksprite;
	} else {
		if hsp >= 0.125 and hsp <= 0.5 {
			sindex = sSnailTurn;
			iindex = 0;
			xindex = 1;
		}
	
		if hsp >= -0.125 and hsp <= 0.125 {
			sindex = sSnailTurn;
			iindex = 1;
			xindex = 1;
		}
	
		if hsp >= -0.5 and hsp <= -0.125	{
			sindex = sSnailTurn;
			iindex = 2;
			xindex = 1;
		}
	}
}
