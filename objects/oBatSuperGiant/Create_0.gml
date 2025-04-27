night = false;

hsp = 0;
vsp = 0;

cx = 0;
cy = 0;

drawhsp = hsp;

dir = image_xscale;

change = false;

startindex = image_index;
palette_index = 0;
drawy = y;

xx = x;
yy = y;

prehsp = hsp;

if dir == -1 then x -= 16;

hsp = image_index == 1 ? 0.5 : -0.5;

set_pallete_index();

sprite_index = sBat;
layer = layer_get_id("Instances_2");
image_xscale = 1;