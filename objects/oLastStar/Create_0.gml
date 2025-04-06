/// @description Insert description here
// You can write your code in this editor
if oCamera.yspawn>500 {visible=true} else {visible=false}

image_index=random_range(0,2)
neww=true
night=false
hsp=0
vsp=0



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

if visible=true
{
if oCamera.yspawn=560 {visible=true} else {visible=false}

wall=instance_create_layer(x+8+(320/2),0,layer,oSolid)
wall.image_yscale=100
wall.visible=false
}