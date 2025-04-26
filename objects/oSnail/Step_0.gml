/// @description Insert description here
// You can write your code in this editor

numb=approach(numb,0,1)

on_ground_var = has_collided(0, 1, true, [oPermaSpike]);
if on_ground_var=false {vsp += grav}
if vsp > 3 {vsp = 3}

object_set_room_wrapping();
//if y > room_height	{y -= 180}
//if x > room_width	{x -= 320}
//if y < 0			{y += 180}
//if x < 0			{x += 320}

if night=true{ sprite_index = idlesprite image_index = 1} else {sprite_index = walksprite}
if ani>0 {sprite_index = idlesprite image_index=0 ani-=1}

if not night
{
	if vsp == 0 
	and abs(image_xscale) == 1
	and (not has_collided(-(sprite_width / 1.3), 2, true, [oPermaSpike]) 
		or has_collided(-(image_xscale * 4), 0, true, [oPermaSpike])
	) {
		image_xscale *= -1;
	}
	//if image_xscale=1 and !(place_meeting(x-(sprite_width/1.3),y+2,oSolid) or place_meeting(x-(sprite_width/1.3),y+2,oPlatGhost) or place_meeting(x-(sprite_width/1.3),y+2,oPermaSpike))
	//	{image_xscale=-image_xscale }

	//if image_xscale=-1 and !(place_meeting(x-(sprite_width/1.3),y+2,oSolid) or place_meeting(x-(sprite_width/1.3),y+2,oPlatGhost) or place_meeting(x-(sprite_width/1.3),y+2,oPermaSpike))
	//	{image_xscale=-image_xscale }
	
	//if place_meeting(x-(image_xscale*4),y,oSolid) or place_meeting(x-(image_xscale*4),y,oPermaSpike)
	//	{image_xscale=-image_xscale }
	
	//if image_xscale=-1  and place_meeting(x + 1, y, oPlatGhostL) and !place_meeting(x, y, oPlatGhostL) {image_xscale=-image_xscale }
	//if image_xscale=1 and place_meeting(x - 1, y, oPlatGhostR) and !place_meeting(x, y, oPlatGhostR) {image_xscale=-image_xscale }
	
	hsp -= image_xscale * 0.075;
	hsp = clamp(hsp, -0.55, 0.55);
}

var nearmush=instance_place(x,y,oMush)
if nearmush != noone {
	if nearmush.image_angle == 0 {
		if place_meeting(x,y,nearmush) and vsp>=0 {
			y=nearmush.y

			nearmush.image_speed=1
			vsp = -4
			if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {
				var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04)
				audio_play_sfx(sfxcogu,false,-16,2)
			} 
			scr_change()
	
			//Partículas
			repeat(random_range(3,5)) {
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
			image_xscale=-1
			hsp_plus=2
			hsp=0.55
		 	if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
	
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
	
		if nearmush.image_angle=-270 or nearmush.image_angle=90
	{
		if place_meeting(x,y,nearmush) and image_xscale=1
		{
			//numb=10
			//y=nearmush.y
			//vsp=-0.55

			nearmush.image_speed=1
			image_xscale=1
			hsp_plus=-2
			hsp=-0.55
		 	if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
	
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

sindex=sprite_index
iindex=image_index
xindex=image_xscale

if night=false  and vsp=0
{
	//if hsp>0.5 or hsp<-0.5 {sindex=sSnailTurn}
	
	if hsp>=0.125 and hsp<=0.5
	{sindex=sSnailTurn iindex=0 xindex=1}
	
	if hsp>=-0.125 and hsp<=0.125
	{sindex=sSnailTurn iindex=1 xindex=1}
	
	if hsp>=-0.5 and hsp<=-0.125
	{sindex=sSnailTurn iindex=2 xindex=1}
}
