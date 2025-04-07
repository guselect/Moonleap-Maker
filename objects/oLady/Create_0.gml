maxspd = 0.55;
levelnumb=0

smove_day=sLadyNight
sturn_day=sLadyTurn

smove_dayB=sLadyDay
sturn_dayB=sLadyTurnNight


if image_index == 1 {
	hsp = 0.55;
} else {
	hsp = -0.55;
}

startindex = image_index;

if sign(sign(image_xscale) == 1) {
	hsp = -0.55;
	startindex = 1;
}

image_xscale = sign(hsp);

if startindex == 0 {
	sprite_index = smove_day;
} else {
	sprite_index = smove_dayB;
}


night=false

hsp=0
vsp=0

cx = 0;
cy = 0;

xx=0
yy=0

layer=layer_get_id("Instances_2")
drawy=y

prehsp = hsp;

if image_index == 1 then
	hsp = maxspd;
else 
	hsp = -maxspd;

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