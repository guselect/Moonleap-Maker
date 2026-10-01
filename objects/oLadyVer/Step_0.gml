if startindex == 0 {
	prevsp += (oCamera.night ? 0.05 : -0.05);
} else {
	prevsp += (oCamera.night ? -0.05 : 0.05);
}

prevsp = clamp(prevsp, -maxspd, maxspd);

object_set_room_wrapping();

if not place_meeting(x, y - 2, oPlayer) {
	drawy = y - 2;
}

drawy = approach(drawy, y, 0.1);

var halfspd = maxspd / 2;
var maxspdm = maxspd - 0.05;

if startindex == 0 {
	image_xscale = sign(prevsp);
	if prevsp > maxspdm or prevsp < -maxspdm {
		sprite_index = smove_day;
	}
	if prevsp >= halfspd and prevsp <= maxspdm {
		sprite_index = sturn_day;
		image_index = 0;
		image_xscale = 1;
	}
	if prevsp >= -halfspd and prevsp <= halfspd {
		sprite_index = sturn_day;
		image_index = 1;
		image_xscale = 1;
	}
	if prevsp >= -maxspdm and prevsp <= -halfspd {
		sprite_index = sturn_day;
		image_index = 2;
		image_xscale = 1;
	}
}

if startindex == 1 {
	image_xscale = sign(prevsp);
	if prevsp > maxspdm or prevsp < -maxspdm {
		sprite_index = sLadyDay;
	}
	
	if prevsp >= halfspd and prevsp <= maxspdm {
		sprite_index = sturn_dayB;
		image_index = 0;
		image_xscale = 1;
	}
	if prevsp >= -halfspd and prevsp <= halfspd {
		sprite_index = sturn_dayB;
		image_index = 1;
		image_xscale = 1;
	}
	if prevsp >= -maxspdm and prevsp <= -halfspd {
		sprite_index = sturn_dayB;
		image_index = 2;
		image_xscale = 1;
	}
}

check_mushroom_collision();

vsp = prevsp;