/// @description Insert description here
// You can write your code in this editor
night=false
ani=0
hsp=0
vsp=0
grav=0.125
hsp_plus=0

change=false
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

sonx=0
sony=0


cooldown=0
/*
var cu=self
instance_create_layer(x-320,y,layer,oMagicOrbClone,{daddy:cu})
instance_create_layer(x+320,y,layer,oMagicOrbClone,{daddy:cu})
instance_create_layer(x,y+180,layer,oMagicOrbClone,{daddy:cu})
instance_create_layer(x,y-180,layer,oMagicOrbClone,{daddy:cu})

