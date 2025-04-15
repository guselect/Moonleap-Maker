wing = 2;
if place_meeting(x+1,y,oBatVer) or place_meeting(x+1,y,oMush) {
	wing = 1;
}

if place_meeting(x-1,y,oBatVer) {
	wing = -1;
}

if place_meeting(x+1,y,oBatVer) and place_meeting(x - 1, y, oBatVer) {
	wing = 0;
}

dir = 1;
vsp = 0.5;
image_xscale = 1;

if image_index == 1 or sign(image_yscale) == -1 {
	dir = -1;
}

startindex = image_index;
//if image_index=0 {sprite_index=sLadyNight} else {sprite_index=sLadyDay}

night=false

hsp=0
vsp=0

cx = 0;
cy = 0;

layer=layer_get_id("Instances_2")
drawy=y

xx = x;
yy = y;

change=false

if instance_exists(oGrassDay)
or (instance_exists(oLevelMaker) and oLevelMaker.selected_style == LEVEL_STYLE.GRASS) {
	palette_index = 0;
} else if instance_exists(oCloudDay)
or (instance_exists(oLevelMaker) and oLevelMaker.selected_style == LEVEL_STYLE.CLOUDS) {
	palette_index = 1;
} else if instance_exists(oFlowerDay)
or (instance_exists(oLevelMaker) and oLevelMaker.selected_style == LEVEL_STYLE.FLOWERS) {
	palette_index = 2;
} else if instance_exists(oSpaceDay)
or (instance_exists(oLevelMaker) and oLevelMaker.selected_style == LEVEL_STYLE.SPACE) {
	palette_index = 3
} else if instance_exists(oDunDay)
or (instance_exists(oLevelMaker) and oLevelMaker.selected_style == LEVEL_STYLE.DUNGEON) {
	palette_index = 4;
}

image_index = 0;
image_yscale = 1;