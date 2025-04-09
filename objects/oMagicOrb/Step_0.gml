/// @description Insert description here
// You can write your code in this editor
if !instance_exists(oPlayer) {exit;}


on_ground_var = has_collided(0, 1) or place_meeting(x, y + 1, oPermaSpike);

if !audio_is_playing(sndPush){audio_play_sfx(sndPush,true,-17,0)}

if flash>0 {flash-=0.25}

if instance_exists(oPlayer)
{

	var px=oPlayer.x var py=oPlayer.y
	var col=false
	
	if distance_to_point(px,py)<10 and vsp>0 and y<py
	{oPlayer.dsquash=true instance_destroy(oPlayer) exit;}
	
	if distance_to_point(x,py)<2 and oPlayer.hsp+oPlayer.vsp!=0
	{
		if distance_to_point(px,py)<8
		{
			if px>x {hsp=-1} else {hsp=1}
			col=true
		}
	
		if distance_to_point(px+320,py)<8
		{
			if px+320>x {hsp=-1} else {hsp=1}
			col=true
		}
	
		if distance_to_point(px-320,py)<8
		{
			if px-320>x {hsp=-1} else {hsp=1}
			col=true
		}
	}
	
	if col=false
	{hsp=approach(hsp,0,0.25) scare=false image_speed=1 }
	else
	{scare=true image_speed=2}
	
	colapproach=approach(colapproach,col,0.1)
	audio_sound_gain(sndPush,colapproach,0)
	
}

//if hsp!=0 and on_ground_var  {if random_range(0,2)>1 {instance_create_layer(x,y+8,layer,oBigDust)}}

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



if !(collision_point(x,bbox_bottom+1,oSolid,false,false) or collision_point(x,bbox_bottom+1,oPlatGhost,false,false))
{sprite_index=sGemFly} else {sprite_index=sGem} 

if vsp>3 {vsp=3}


	nearmush=instance_place(x,y,oMush)
if 	nearmush!=noone and instance_exists(oPlayer)
{


	if nearmush.image_angle=0
	{
		if place_meeting(x,y,nearmush) and vsp>=0
		{
			y=nearmush.y

			nearmush.image_speed=1
			if nearmush.gray=false {oPlayer.vsp = -4} else {vsp= -4}
			 	if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
			if nearmush.gray=false {scr_change()}
	
			//Partículas
			repeat(random_range(3,5))
				{
				var dust=instance_create_layer(x,y+(sprite_height/2),"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10)
				dust.vsp=vsp/random_range(5,10)
				}
			}
	}

	if nearmush.image_angle=-90 or nearmush.image_angle=270
	{
		if place_meeting(x,y,nearmush) and image_xscale=1
		{
			//numb=10
			//y=nearmush.y
			//vsp=-0.55

			nearmush.image_speed=1

			
			if nearmush.gray=false {			oPlayer.image_xscale=-1
			oPlayer.hsp_plus=2
			oPlayer.hsp=0.55} else {hsp=2}
			
			
		 	if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
	
			if nearmush.gray=false {scr_change()}
	
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
	
		if nearmush.image_angle=-270 or nearmush.image_angle=90
	{
		if place_meeting(x,y,nearmush) and image_xscale=1
		{
			//numb=10
			//y=nearmush.y
			//vsp=-0.55

			nearmush.image_speed=1
			
			if nearmush.gray=false
			{
			oPlayer.image_xscale=1
			oPlayer.hsp_plus=-2
			oPlayer.hsp=-0.55
			}
			else
			{
			hsp=-2	
			}
		 	if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
	
			if nearmush.gray=false {scr_change()}
	
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

	nearmush=instance_place(x,y,oMush)
if 	nearmush!=noone
{


	if nearmush.image_angle=0
	{
		if place_meeting(x,y,nearmush) and vsp>=0
		{
			y=nearmush.y

			nearmush.image_speed=1
			
			if nearmush.gray=false
			{
			oPlayer.vsp = -(oPlayer.jumpspeed+0.65)
			}
			else
			{
			vsp= -(oPlayer.jumpspeed+0.65)
			}
			 	if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
			if nearmush.gray=false {scr_change()}
	
			//Partículas
			repeat(random_range(3,5))
				{
				var dust=instance_create_layer(x,y+(sprite_height/2),"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10)
				dust.vsp=vsp/random_range(5,10)
				}
			}
	}

	if nearmush.image_angle=-90 or nearmush.image_angle=270
	{
		if place_meeting(x,y,nearmush) and image_xscale=1
		{
			//numb=10
			//y=nearmush.y
			//vsp=-0.55

			nearmush.image_speed=1
			
			if nearmush.gray=false
			{
			oPlayer.image_xscale=-1
			oPlayer.hsp=oPlayer.jumpspeed
			}
			else
			{
			hsp=	oPlayer.jumpspeed
			}
		 	if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
	
			if nearmush.gray=false {scr_change()}
	
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
	
		if nearmush.image_angle=-270 or nearmush.image_angle=90
	{
		if place_meeting(x,y,nearmush) and image_xscale=1
		{
			//numb=10
			//y=nearmush.y
			//vsp=-0.55

			nearmush.image_speed=1
			if nearmush.gray=false
			{
			oPlayer.image_xscale=1
			oPlayer.hsp=-oPlayer.jumpspeed
			}
			else
			{
			hsp=-oPlayer.jumpspeed
			}
			
		 	if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
	
			if nearmush.gray=false {scr_change()}
	
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

cooldown=approach(cooldown,0,1)

if place_meeting(x,y,oSpike) {instance_destroy()}