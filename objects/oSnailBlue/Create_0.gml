/// @description Insert description here
// You can write your code in this editor


night=false
ani=0
hsp=-(image_xscale*0.5)
vsp=0
grav=0.125
idlesprite=sSnailIdleB
walksprite=sSnailWalkB


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
