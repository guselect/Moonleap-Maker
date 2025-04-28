on_ground_var = has_collided(0, 1, true, [oPermaSpike]);

if not on_ground_var {
	vsp = min(vsp + grav, 3);
}

object_set_room_wrapping();

var _y_diff = yprev - y;

if place_meeting(x, y, oSolid)
or (sign(_y_diff) == 1 and place_meeting(x, y - 1, oPlatGhostInv)) {
	instance_destroy();
}

yprev = y;

sprite_index = sSnailWalk;

if vsp == 0
and abs(image_xscale) == 1
and not is_stuck()
and (not has_collided(-(sprite_width / 2), 2, true, [oPermaSpike]) 
	or has_collided(-(image_xscale * 4), 0, true, [oPermaSpike])
) {
	image_xscale *= -1;
}

if is_stuck() {
	hsp = 0;
	if sign(image_xscale) != 0 {
		image_xscale = sign(image_xscale);
	}
} else {
	hsp -= image_xscale * 0.075;	
}
hsp = clamp(hsp, -0.55, 0.55);

var nearmush = instance_place(x, y, oMush);
if nearmush != noone {
	if nearmush.image_angle == 0 and place_meeting(x, y, nearmush) and vsp >= 0 {
		y = nearmush.y;
		nearmush.image_speed = 1;
		vsp = -3.5;
		hsp = 0;
			
		play_mushroom_sound();
		scr_change();
		shake_gamepad(0.4, 2);
		spawn_dust_particles();
	}

	if (nearmush.image_angle == -90 or nearmush.image_angle == 270) 
	and place_meeting(x, y, nearmush) and image_xscale == 1 {
		nearmush.image_speed=1
		image_xscale=-1
		hsp_plus=2
		hsp=0.55
			
		play_mushroom_sound();
		scr_change();
		shake_gamepad(0.4, 2);
		spawn_dust_particles();
	}
	
	if (nearmush.image_angle == -270 or nearmush.image_angle == 90) 
	and place_meeting(x, y, nearmush) and image_xscale == 1 {

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
 
sindex = sprite_index;
iindex = image_index;
xindex = image_xscale;

if is_stuck() {
	sprite_index = sSnailWalk;
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
