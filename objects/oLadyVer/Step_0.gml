if startindex == 0 {
	prevsp += (oCamera.night ? 0.05 : -0.05);
} else {
	prevsp += (oCamera.night ? -0.05 : 0.05);
}

prevsp = clamp(prevsp, -maxspd, maxspd);

object_set_room_wrapping();
//if y>room_height{y-=180}
//if x>room_width{x-=320}
//if y<0{y+=180}
//if x<0{x+=320}

if not place_meeting(x, y - 2, oPlayer) {
	drawy = y - 2
}

drawy = approach(drawy, y, 0.1);

var halfspd=maxspd/2
var maxspdm=maxspd-0.05

if startindex == 0
{
	image_xscale = sign(prevsp);
	if prevsp > maxspdm or prevsp < -maxspdm {
		sprite_index = smove_day;
	}
	if prevsp >= halfspd and prevsp <= maxspdm {
		sprite_index = sturn_day;
		image_index = 0;
		image_xscale = 1;
	}
	if prevsp >= -halfspd and prevsp <= halfspd {
		sprite_index = sturn_day;
		image_index = 1;
		image_xscale = 1;
	}
	if prevsp >= -maxspdm and prevsp <= -halfspd {
		sprite_index = sturn_day;
		image_index = 2;
		image_xscale = 1;
	}
}


if startindex == 1
{
	image_xscale = sign(prevsp);
	if prevsp > maxspdm or prevsp < -maxspdm {
		sprite_index = sLadyDay;
	}
	
	if prevsp >= halfspd and prevsp <= maxspdm {
		sprite_index = sturn_dayB;
		image_index = 0;
		image_xscale = 1;
	}
	if prevsp >= -halfspd and prevsp <= halfspd {
		sprite_index = sturn_dayB;
		image_index = 1;
		image_xscale = 1;
	}
	if prevsp >= -maxspdm and prevsp <= -halfspd {
		sprite_index = sturn_dayB;
		image_index = 2;
		image_xscale = 1;
	}
}

if instance_exists(oMush) {
	var nearmush = instance_nearest(x,y,oMush);
	
	if nearmush.image_speed != 0 {
		nearmush = noone;
		exit;
	}
	
	if nearmush.image_angle == 180 {
		if place_meeting(x,y,nearmush) and image_xscale=-1 {
			nearmush.image_speed=1
			prevsp=maxspd
			if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {
				var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04)
				audio_play_sfx(sfxcogu,false,-16,2)
			} 
			scr_change()
			//Partículas
			shake_gamepad(0.4,2)
			repeat(random_range(3,5)) {
				var dust=instance_create_layer(x-(sprite_width/2),y+(sprite_width/2),"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10); dust.vsp=vsp/random_range(5,10)
			}
		}
	}
	if nearmush.image_angle == 0 {
		if place_meeting(x, y, nearmush) and image_xscale == 1 {
			nearmush.image_speed=1
			prevsp=-maxspd
			 	if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
			scr_change()
			//Partículas
			shake_gamepad(0.4,2)
			repeat(random_range(3,5)) {
				var dust=instance_create_layer(x-(sprite_width/2),y+(sprite_width/2),"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10); dust.vsp=vsp/random_range(5,10)
			}
		}
	}
}

vsp = prevsp;