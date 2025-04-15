/// @description Insert description here
// You can write your code in this editor
//mymask=instance_create_layer(x,y,layer,oSnailMask)

numb=0
night=false
ani=0
hsp=-(image_xscale*0.6)
vsp=0
grav=0.125
turn=false
idlesprite=sSnailIdleNight
walksprite=sSnailWalkNight


hsp_plus=0
ani=0
hsp=-(image_xscale*0.6)
vsp=0
grav=0.125


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

levelnumb=0
levelnumb=real(string_digits(room_get_name(room)))

palette_index=0

if instance_exists(oGrassDay)
{palette_index=0 exit;}

if instance_exists(oCloudDay)
{palette_index=1 exit;}

if instance_exists(oFlowerDay)
{palette_index=2 exit;}

if instance_exists(oSpaceDay)
{palette_index=3 exit;}

