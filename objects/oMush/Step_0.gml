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

find_object_to_glue();
glue_on_object_if_exists();

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