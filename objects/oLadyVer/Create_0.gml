/// @description Insert description here
// You can write your code in this editor
smove_day=sLadyNight
sturn_day=sLadyTurn
maxspd=0.55
smove_dayB=sLadyDay
sturn_dayB=sLadyTurnNight

if image_index == 1 {
	vsp = 0.55;
} else {
	vsp = -0.55;
}

startindex = image_index;

if sign(image_yscale) == 1 {
	vsp = -0.55;
	startindex = 1;
}

if startindex == 0 {
	sprite_index = sLadyNight;
} else {
	sprite_index = sLadyDay;
}

image_yscale = 1;
image_angle = -90;

levelnumb=0
night=false

hsp=0
vsp=0
prevsp=0

cx = 0;
cy = 0;

xx=0
yy=0

if instance_exists(oGrassDay)
{palette_index=0 exit;}

if instance_exists(oCloudDay)
{palette_index=1 exit;}

if instance_exists(oFlowerDay)
{palette_index=2 exit;}

if instance_exists(oSpaceDay)
{palette_index=3 exit;}

if instance_exists(oDunDay)
{palette_index=4 exit;}

mask_index=sLadyVerMask