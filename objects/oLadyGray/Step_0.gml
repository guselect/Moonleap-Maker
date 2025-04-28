if startindex == 0 {
	prehsp += (mynight ? 0.05 : -0.05);
} else {
	prehsp += (mynight ? -0.05 : 0.05);
}

prehsp = clamp(prehsp, -maxspd, maxspd);

object_set_room_wrapping();

if not place_meeting(x, y - 2, oPlayer) {
	drawy = y - 2;
}

drawy = approach(drawy, y, 0.1);

var halfspd = maxspd / 2;
var maxspdm = maxspd - 0.05;

if startindex == 0 {
	image_xscale = sign(prehsp);
	
	if prehsp > maxspdm or prehsp < -maxspdm {
		sprite_index = smove_day
	}
	if prehsp >= halfspd and prehsp <= maxspdm {
		sprite_index = sturn_day;
		image_index = 0;
		image_xscale = 1;
	}
	if prehsp >= -halfspd and prehsp <= halfspd {
		sprite_index = sturn_day;
		image_index = 1;
		image_xscale = 1;
	}
	if prehsp >= -maxspdm and prehsp <= -halfspd {
		sprite_index = sturn_day;
		image_index = 2;
		image_xscale = 1;
	}
}

if startindex == 1 {
	image_xscale = sign(prehsp);
	
	if prehsp > maxspdm or prehsp < -maxspdm {
		sprite_index = smove_dayB;
	}
	if prehsp >= halfspd and prehsp <= maxspdm {
		sprite_index = sturn_dayB;
		image_index = 0;
		image_xscale = 1;
	}
	if prehsp >= -halfspd and prehsp <= halfspd {
		sprite_index = sturn_dayB;
		image_index = 1;
		image_xscale = 1;
	}
	if prehsp >= -maxspdm and prehsp <= -halfspd {
		sprite_index = sturn_dayB;
		image_index = 2;
		image_xscale = 1;
	}
}

if instance_exists(oMush) {
	var nearmush = instance_nearest(x, y, oMush);
	
	if nearmush.image_speed != 0 {
		nearmush = noone;
		exit;
	}
	
	if (nearmush.image_angle == -90 or nearmush.image_angle == 270)
	and place_meeting(x, y, nearmush) and image_xscale == -1 {
		nearmush.image_speed = 1;
		prehsp = maxspd;
		mynight = not mynight;
		play_mushroom_sound();
		scr_change();
		shake_gamepad(0.4, 2);
		spawn_dust_particles();
	}
	
	if (nearmush.image_angle == -270 or nearmush.image_angle == 90)
	and place_meeting(x, y, nearmush) and image_xscale == 1 {
		nearmush.image_speed=1
		prehsp = -maxspd;
		mynight = not mynight;
		play_mushroom_sound();
		scr_change();
		shake_gamepad(0.4, 2);
		spawn_dust_particles();
	}
}

hsp = prehsp;