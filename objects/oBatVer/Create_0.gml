hsp = 0;
vsp = 0;
wing = 2;
startindex = image_index;
dir = image_yscale;
night = false;
change = false;
early_night = false;

cx = 0;
cy = 0;

drawy = y;

vsp = image_index == 1 ? 0.5 : -0.5;

xx = x;
yy = y;

set_pallete_index();

if place_meeting(x + 1, y, oBatVer) or place_meeting(x + 1, y, oMush) {
	wing = 1;
} else if place_meeting(x - 1, y, oBatVer) {
	wing = -1;
} else if place_meeting(x + 1, y, oBatVer) and place_meeting(x - 1, y, oBatVer) {
	wing = 0;
}

mask_index = sprite_index;
image_xscale = 1;
image_yscale = 1;
image_index = 0;
layer = layer_get_id("Instances_2");