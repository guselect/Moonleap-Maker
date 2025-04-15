/// @description Insert description here
// You can write your code in this editor

if !instance_exists(oPlayer) {exit;}

on_ground_var = has_collided(0, 1) or place_meeting(x, y + 1, oPermaSpike);


if instance_exists(oPlayer)
{
	if place_meeting(x-2,y,oPlayer)
	{if oPlayer.hsp>0 {hsp=oPlayer.hsp}}

	if place_meeting(x+2,y,oPlayer)
	{if oPlayer.hsp<0 {hsp=oPlayer.hsp}}
	
	if !(place_meeting(x-2,y,oPlayer) or place_meeting(x+2,y,oPlayer))
	{hsp=approach(hsp,0,0.05)}
}
if hsp!=0  {if random_range(0,2)>1 {instance_create_layer(x,y+8,layer,oBigDust)}}

//hsp=approach(hsp,0,0.25)

sonx=0
sony=0

if y>room_height{y-=180 sony-=180}
if x>room_width{x-=320 sonx=-320}
if y<0{y+=180 sony=180}
if x<0{x+=320 sonx=320}


if on_ground_var=false
{
vsp+=grav
}


if vsp>3 {vsp=3}


if place_meeting(x,y,oSpike) {instance_destroy()}

hsp_plus=approach(hsp_plus,0,0.1)

cooldown=approach(cooldown,0,1)