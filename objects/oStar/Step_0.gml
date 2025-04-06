/// @description Insert description here
// You can write your code in this editor

on_ground_var= has_collided(0, 1) or place_meeting(x, y + 1, oPermaSpike);
if on_ground_var=false and image_angle=0 {vsp+=0.125}
if vsp>4 {vsp=4}

if y>room_height{y-=180}
if x>room_width{x-=320}
if y<0{y+=180}
if x<0{x+=320}

if instance_exists(snail)
{
	if snail != noone
	{
		x=snail.x
		y=snail.y-8
		image_xscale=snail.image_xscale
		sprite_index=sStarAlive
		exit
	}
}

if bat!=noone
{
	if (place_meeting(x, y + 1, bat) && !place_meeting(x, y, bat)) {
		x = bat.x - 8;
	}
}


if batver!=noone
{
	if  place_meeting(x, y + 1, batver) {
		y = batver.y - 24;
	}
}

if place_meeting(x,y,oSpike) {
	instance_destroy()
}