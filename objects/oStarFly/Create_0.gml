/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

/// @description Insert description here
// You can write your code in this editor
snail=instance_place(x,y+2,oSnailGray)
bat=instance_place(x,y+2,oBat)
batver=instance_place(x,y+1,oBatVer)

image_index=random_range(0,2)
neww=true
night=false
hsp=0
vsp=0

//if instance_exists(oFlowerDay) or instance_exists(oSpaceDay) or instance_exists(oDunDay)  {sprite_index=sStarFlower}

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





