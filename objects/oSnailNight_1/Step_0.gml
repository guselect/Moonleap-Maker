/// @description Insert description here
// You can write your code in this editor

numb=approach(numb,0,1)

on_ground_var= has_collided(0, 1) or place_meeting(x, y + 1, oPermaSpike);
if on_ground_var=false {vsp+=grav}
if vsp>3 {vsp=3}

if y>room_height{y-=180}
if x>room_width{x-=320}
if y<0{y+=180}
if x<0{x+=320}



if night=false{ sprite_index=idlesprite image_index=1} else { sprite_index=walksprite}
if ani>0 {sprite_index=idlesprite image_index=0 ani-=1}


if night=true
{
if image_xscale=1 and !(place_meeting(x-(sprite_width/1.3),y+2,oSolid) or place_meeting(x-(sprite_width/1.3),y+2,oPlatGhost) or place_meeting(x-(sprite_width/1.3),y+2,oPermaSpike))
	{image_xscale=-image_xscale }

if image_xscale=-1 and !(place_meeting(x-(sprite_width/1.3),y+2,oSolid) or place_meeting(x-(sprite_width/1.3),y+2,oPlatGhost) or place_meeting(x-(sprite_width/1.3),y+2,oPermaSpike))
	{image_xscale=-image_xscale }
	
if place_meeting(x-(image_xscale*4),y,oSolid) or place_meeting(x-(image_xscale*4),y,oPermaSpike)
	{image_xscale=-image_xscale }
	
	//if sign(hsp)=1  and place_meeting(x + 1, y, oPlatGhostL) and !place_meeting(x, y, oPlatGhostL) {image_xscale=-image_xscale}
	//if sign(hsp)=-1 and place_meeting(x - 1, y, oPlatGhostR) and !place_meeting(x, y, oPlatGhostR) {image_xscale=-image_xscale}
	

hsp-=image_xscale*0.1
hsp=clamp(hsp,-0.6,0.6)
}


if instance_exists(oMush)
{
	nearmush=instance_nearest(x,y,oMush); if nearmush.image_speed!=0 {nearmush=noone exit;}

	if nearmush.image_angle=0
	{
		if place_meeting(x,y,nearmush) and vsp>=0
		{
			y=nearmush.y

			nearmush.image_speed=1
			vsp = -4
			container_play( "SfxJump")
			scr_change()
	
			//Partículas
			repeat(random_range(3,5))
				{
				var dust=instance_create_layer(x,y+(sprite_height/2),"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10)
				dust.vsp=vsp/random_range(5,10)
				}
			}
	}

	if nearmush.image_angle=-90
	{
		if place_meeting(x,y,nearmush) and image_xscale=1
		{
			//numb=10
			//y=nearmush.y
			//vsp=-0.5

			nearmush.image_speed=1
			image_xscale=-1
			hsp_plus=2
			hsp=0.6
		container_play( "SfxJump")
	
			scr_change()
	
			//Partículas
			shake_gamepad(0.4,2)
			repeat(random_range(3,5))
				{
				var dust=instance_create_layer(x-(sprite_width/2),y+(sprite_width/2),"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10)
				dust.vsp=vsp/random_range(5,10)
				}
			}
	}
	
		if nearmush.image_angle=-270
	{
		if place_meeting(x,y,nearmush) and image_xscale=1
		{
			//numb=10
			//y=nearmush.y
			//vsp=-0.5

			nearmush.image_speed=1
			image_xscale=1
			hsp_plus=-2
			hsp=-0.6
		container_play( "SfxJump")
	
			scr_change()
	
			//Partículas
			shake_gamepad(0.4,2)
			repeat(random_range(3,5))
				{
				var dust=instance_create_layer(x-(sprite_width/2),y+(sprite_width/2),"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10)
				dust.vsp=vsp/random_range(5,10)
				}
			}
	}
	
}

hsp_plus=approach(hsp_plus,0,0.1)

if hsp_plus>0
{
repeat(random_range(3,5))
	{
	var dust=instance_create_layer(x,y+(sprite_height)-2,"Instances_2",oBigDust)
	dust.hsp=hsp/random_range(5,10)
	dust.vsp=vsp/random_range(5,10)
	}
}