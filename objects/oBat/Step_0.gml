/// @description Insert description here
// You can write your code in this editor
if xstart>0 and xstart<320
{
	if y>room_height{y-=180}
	if x>room_width{x-=320}
	if y<0{y+=180}
	if x<0{x+=320}
}

if has_collided(sign(hsp), 0, true, [oPermaSpike]) then dir *= -1;

//if place_meeting(x + 1,y,oSolid) or (place_meeting(x + 1,y,oPlatGhostL) and !place_meeting(x,y,oPlatGhostL)) {dir=-1}
//if place_meeting(x - 1,y,oSolid) or (place_meeting(x - 1,y,oPlatGhostR) and !place_meeting(x,y,oPlatGhostR)) {dir=1 }

if instance_exists(oMush) {
	if place_meeting(x + 1,y,oMush) and dir == 1 {
		dir = -1;
		scr_change() 
		if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
	}

	if place_meeting(x - 1,y,oMush) and dir == -1
	{
		dir = 1;
		scr_change()
		if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04))
			{var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
	}
}
if dir == 1 {
	if x < xx {
		hsp += 0.1;
	} else {
		hsp = 0;
	}
}

if dir == -1 {
	if x > xx {
		hsp -= 0.1;
	} else {
		hsp = 0;
	}
}



hsp=clamp(hsp,-1,1)

if x=xx {image_speed=1 } else {image_speed=3} 

if dir=1 {sprite_index=sBat} else {sprite_index=sBatInv}

