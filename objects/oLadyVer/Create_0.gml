levelnumb = 0;
night = false;
hsp = 0;
vsp = 0;
prevsp = 0;
cx = 0;
cy = 0;
xx = 0;
yy = 0;
maxspd = 0.55;
drawy = y;

smove_day=sLadyNight
sturn_day=sLadyTurn
smove_dayB=sLadyDay
sturn_dayB=sLadyTurnNight

startindex = image_index;



// Moonleap Maker flips the object changing image_xscale instead of image_index
if sign(image_yscale) == -1 {
	vsp = maxspd;
	startindex = 1;
}

vsp = startindex == 1 ? maxspd : -maxspd;
image_angle = -90;
sprite_index = startindex == 0 ? sLadyNight : sLadyDay;

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