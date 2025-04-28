glued = false;

if image_speed != 0 {
	mask_index = -1
} else if bigmask {
	mask_index = sMushBigMask;
} else {
	mask_index = sSuperMush;
}

if image_index > image_number - 1 {
	image_index = 0;
	image_speed = 0;
	xscale = -xscale;
}

if xscale == 1 {
	sprite_index = sMush;
} else {
	sprite_index = sMushInv;
}

/*
if instance_exists(oLadyVer)
{
	if image_angle=-90 or image_angle=90
	{
	near_lady=instance_nearest(x,y,oLadyVer)
	if distance_to_object(near_lady)<2
	{y=near_lady.y-8}
	}
	
	if image_angle=0 or image_angle=180
	{
	near_lady=instance_nearest(x,y,oLadyVer)
	if distance_to_object(near_lady)<2
	{x=near_lady.x}
	}
}
*/

if instance_exists(oLady) {
	/*
	if image_angle=-90 or image_angle=90
	{
	near_lady=instance_nearest(x,y,oLady)
	if distance_to_object(near_lady)<2
	{y=near_lady.y-8}
	}
	*/
	if image_angle == 0 or image_angle == 180 {
		near_lady = instance_nearest(x, y, oLady);
		
		if distance_to_object(near_lady) < 2 {
			x = near_lady.x - 8;
			glued = true;
		}
	}
}


if instance_exists(oBatVer) {
	if image_angle == -90 or image_angle == 90 {
		near_lady = instance_nearest(x, y, oBatVer);
		
		if distance_to_object(near_lady) < 4 {
			y = near_lady.y - 8;
			glued = true;
		}
	}
	
	if image_angle == 0 or image_angle == 180 {
		near_lady = instance_nearest(x, y, oBatVer);
		
		if distance_to_object(near_lady) < 4 {
			x = near_lady.x;
			glued = true;
		}
	}
}

if instance_exists(oBat) {
	if image_angle == -90 or image_angle == 90 {
		near_lady = instance_nearest(x, y, oBat);
		
		if distance_to_object(near_lady) < 4 {
			y = near_lady.y - 8
			glued = true;
		}
	}
	
	if image_angle == 0 or image_angle == 180 {
		near_lady = instance_nearest(x, y, oBat);
		
		if distance_to_object(near_lady) < 4 {
			x = near_lady.x - 8;
			glued = true;
		}
	}
}

// ---- STAR COLLISION ----
var _star = instance_place(x, y, oStar);
if _star != noone and _star.visible {
	if not _star.neww {
		audio_play_sfx(sndStarWrong, false, -1.3, 0);
	}
	
	instance_destroy(_star);
	flash = 1;
}

if flash > 0 {
	flash = approach(flash, 0, 0.2);
}