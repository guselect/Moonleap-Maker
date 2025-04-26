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

layer = layer_get_id("Instances_2");
drawy = y;

vsp = image_index == 1 ? 0.5 : -0.5;

xx = x;
yy = y;

mask_index = sprite_index;
image_yscale = 1;
image_index = 0;

if instance_exists(oGrassDay) {
	palette_index = 0;
} else if instance_exists(oCloudDay) {
	palette_index = 1;
} else if instance_exists(oFlowerDay) {
	palette_index = 2;
} else if instance_exists(oSpaceDay) {
	palette_index = 3;
} else if instance_exists(oDunDay) {
	palette_index = 4;
}

if place_meeting(x+1,y,oBatVer) or place_meeting(x+1,y,oMush) {
	wing = 1;
} else if place_meeting(x-1,y,oBatVer) {
	wing = -1;
} else if place_meeting(x+1,y,oBatVer) and place_meeting(x - 1, y, oBatVer) {
	wing = 0;
}