levelnumb=0
maxspd = 0.55;

if room!=RoomMenu and room!=RoomMenu2
{
levelnumb=real(string_digits(room_get_name(room)))
if levelnumb=16 {levelnumb=0}

//if levelnumb<10 {oDust.sprite_index=sDUST}
}


smove_day=sLadyNight
sturn_day=sLadyTurn

smove_dayB=sLadyDay
sturn_dayB=sLadyTurnNight

hsp = 0.55;
startindex = image_index;

if image_index == 1 {
	hsp = -0.55;
}

if sign(image_xscale) == -1 {
	hsp = -0.55;
	startindex = 1;
}

image_xscale = sign(hsp);

if startindex == 0 {
	sprite_index = smove_day;
} else {
	sprite_index = smove_dayB;
}


mynight=true

hsp=0
vsp=0

cx = 0;
cy = 0;

xx=0
yy=0

layer=layer_get_id("Instances_2")
drawy=y

prehsp=hsp

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