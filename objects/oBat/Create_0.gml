hsp = 0;
vsp = 0;

dir = image_xscale;
drawhsp = image_xscale;
mask_index = sprite_index;
image_xscale = 1;

hsp = image_index == 1 ? 0.5 : -0.5;
startindex = image_index;
night = false;
early_night = false;

cx = 0;
cy = 0;

layer = layer_get_id("Instances_2");
drawy = y;

prehsp = hsp;

xx = x;
yy = y;

change = false
palette_index = 4;

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

change_dir_on_collide = function() {
	if not has_collided(sign(hsp), 0, true, [oPermaSpike]) then return;
	
	dir *= -1;
}

change_dir_on_collide();