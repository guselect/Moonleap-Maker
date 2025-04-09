/// @description Insert description here
// You can write your code in this editor
sindex=sprite_index
iindex=image_index
xindex=image_xscale
levelnumb=0
hsp_plus=0

if room!=RoomMenu and room!=RoomMenu2
{
levelnumb=real(string_digits(room_get_name(room)))
if levelnumb=16 {levelnumb=0}

//if levelnumb<10 {oDust.sprite_index=sDUST}
}

numb=0
night=false
ani=0
hsp=-(image_xscale*0.55)
vsp=0
grav=0.125
turn=false
idlesprite=sSnailIdle
walksprite=sSnailWalk

// new movement code

jumped = false;
landed = false;

platform_target = 0;
wall_target     = 0;

on_ground_var = has_collided(0, 1);

// Used for sub-pixel movement
cx = 0;
cy = 0;

c_left    = place_meeting(x - 1, y, oSolid);
c_right   = place_meeting(x + 1, y, oSolid);
sticking = false



palette_index=0

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
