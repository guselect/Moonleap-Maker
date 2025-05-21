if startindex == 0 {
	prehsp += (oCamera.night ? 0.05 : -0.05);
} else {
	prehsp += (oCamera.night ? -0.05 : 0.05);
}

prehsp = clamp(prehsp, -maxspd, maxspd);

object_set_room_wrapping();

if not place_meeting(x, y - 2, oPlayer) {
	drawy = y - 2;
}

drawy = approach(drawy, y, 0.1);

var halfspd = maxspd / 2;
var maxspdm = maxspd - 0.05;

if startindex == 0
{
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

if startindex == 1
{
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

check_mushroom_collision();

hsp = prehsp;