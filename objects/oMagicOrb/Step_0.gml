if not instance_exists(oPlayer) then exit;

on_ground_var = has_collided(0, 1) or place_meeting(x, y + 1, oPermaSpike);

if !audio_is_playing(sndPush){audio_play_sfx(sndPush,true,-17,0)}

if flash>0 {flash-=0.25}

if instance_exists(oPlayer) {
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
	
	if not col{
        hsp=approach(hsp,0,0.25)
        scare = false;
        image_speed = 1;
    } else {
        scare = true;
        image_speed = 2;
    }
	
	colapproach = approach(colapproach, col, 0.1);
	audio_sound_gain(sndPush, colapproach, 0);
}

object_set_room_wrapping();
//if y > room_height then y -= room_height;
//if x > room_width then x -= room_width;
//if y < 0 then y += room_height;
//if x < 0 then x += room_width;

if not on_ground_var {
    vsp += grav;
}

if not (collision_point(x, bbox_bottom + 1, oSolid, false, false) 
    or collision_point(x, bbox_bottom + 1, oPlatGhost, false, false)
) {
    sprite_index = sGemFly;
} else {
    sprite_index = sGem;
} 

vsp = min(vsp, 3);

var nearmush = instance_place(x, y, oMush);
if nearmush != noone and instance_exists(oPlayer) {
	if nearmush.image_angle == 0 {
		if place_meeting(x,y,nearmush) and vsp>=0 {
			y=nearmush.y

			nearmush.image_speed=1
			if nearmush.gray=false {oPlayer.vsp = -4} else {vsp= -4}
			 	if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
			if nearmush.gray=false {scr_change()}
	
			//Partículas
			repeat(random_range(3,5)) {
				var dust=instance_create_layer(x,y+(sprite_height/2),"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10)
				dust.vsp=vsp/random_range(5,10)
			}
		}
	}

	if nearmush.image_angle == -90 or nearmush.image_angle == 270 {
		if place_meeting(x, y, nearmush) and image_xscale == 1 {
			nearmush.image_speed=1

			if not nearmush.gray=false {
                oPlayer.image_xscale=-1
			    oPlayer.hsp_plus=2
			    oPlayer.hsp=0.55
            } else {
                hsp = 2
            }
			
			
		 	if not (audio_is_playing(snd_cogumelo_01) 
                or audio_is_playing(snd_cogumelo_02) 
                or audio_is_playing(snd_cogumelo_03) 
                or audio_is_playing(snd_cogumelo_04)
            ) {
                var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
                audio_play_sfx(sfxcogu,false,-16,2);
            } 
	
			if not nearmush.gray {
                scr_change();
            }
	
			//Partículas
			shake_gamepad(0.4, 2)
			repeat(random_range(3, 5)) {
				var dust = instance_create_layer(x-(sprite_width/2),y+(sprite_width/2),"Instances_2",oBigDust)
				dust.hsp = hsp / random_range(5,10)
				dust.vsp = vsp / random_range(5,10)
            }
        }
	}

	if nearmush.image_angle == -270 or nearmush.image_angle == 90 {
		if place_meeting(x, y, nearmush) and image_xscale == 1 {
			nearmush.image_speed = 1;
			
			if not nearmush.gray {
    			oPlayer.image_xscale=1
    			oPlayer.hsp_plus=-2
    			oPlayer.hsp=-0.55
			} else {
			    hsp = -2;
			}

		 	if not (audio_is_playing(snd_cogumelo_01) 
                or audio_is_playing(snd_cogumelo_02) 
                or audio_is_playing(snd_cogumelo_03) 
                or audio_is_playing(snd_cogumelo_04)
            ) {
                var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
                audio_play_sfx(sfxcogu,false,-16,2);
            } 
	
			if not nearmush.gray {
                scr_change();
            }
	
			//Partículas
			shake_gamepad(0.4, 2)
			repeat(random_range(3, 5)) {
				var dust = instance_create_layer(x-(sprite_width/2),y+(sprite_width/2),"Instances_2",oBigDust)
				dust.hsp = hsp / random_range(5,10)
				dust.vsp = vsp / random_range(5,10)
            }
	}
	
}
}
hsp_plus = approach(hsp_plus, 0, 0.1);

nearmush = instance_place(x, y, oMush); 
if nearmush != noone {
	if nearmush.image_angle == 0 
    and place_meeting(x, y, nearmush) 
    and vsp >= 0 {
        y = nearmush.y

        nearmush.image_speed=1
        
        if not nearmush.gray {
            oPlayer.vsp = -(oPlayer.jumpspeed+0.65)
        } else {
            vsp= -(oPlayer.jumpspeed+0.65)
        }

        if not (audio_is_playing(snd_cogumelo_01)
            or audio_is_playing(snd_cogumelo_02)
            or audio_is_playing(snd_cogumelo_03)
            or audio_is_playing(snd_cogumelo_04)
        ) {
            var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
            audio_play_sfx(sfxcogu,false,-16,2);
        }

        if not nearmush.gray {
            scr_change() 
        }

        //Partículas
        repeat(random_range(3, 5)) {
            var dust=instance_create_layer(x,y+(sprite_height/2),"Instances_2",oBigDust)
            dust.hsp=hsp/random_range(5,10)
            dust.vsp=vsp/random_range(5,10)
        } 
	}

	if nearmush.image_angle == -90 or nearmush.image_angle == 270 {
		if place_meeting(x, y, nearmush) and image_xscale == 1 {
			nearmush.image_speed = 1;
			
			if not nearmush.gray {
    			oPlayer.image_xscale = -1;
    			oPlayer.hsp = oPlayer.jumpspeed;
			} else {
			    hsp = oPlayer.jumpspeed;
			}

		 	if not (audio_is_playing(snd_cogumelo_01)
                or audio_is_playing(snd_cogumelo_02)
                or audio_is_playing(snd_cogumelo_03)
                or audio_is_playing(snd_cogumelo_04)
            ) {
                var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04);
                audio_play_sfx(sfxcogu, false, -16, 2);
            } 
	
			if not nearmush.gray {
                scr_change();
            }
	
			//Partículas
			shake_gamepad(0.4, 2);
			repeat(random_range(3, 5)) {
				var dust=instance_create_layer(x-(sprite_width/2),y+(sprite_width/2),"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10)
				dust.vsp=vsp/random_range(5,10) 
            } 
        }
	}

	if nearmush.image_angle == -270 or nearmush.image_angle == 90 {
		if place_meeting(x, y, nearmush) and image_xscale == 1 {
			nearmush.image_speed = 1;
			if not nearmush.gray {
    			oPlayer.image_xscale=1
    			oPlayer.hsp=-oPlayer.jumpspeed
			} else {
			    hsp=-oPlayer.jumpspeed
			}
			
		 	if !(audio_is_playing(snd_cogumelo_01) or audio_is_playing(snd_cogumelo_02) or audio_is_playing(snd_cogumelo_03) or audio_is_playing(snd_cogumelo_04)) {var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)} 
	
			if nearmush.gray=false {scr_change()}
	
			//Partículas
			shake_gamepad(0.4, 2);
			repeat(random_range(3,5)) {
				var dust=instance_create_layer(x-(sprite_width/2),y+(sprite_width/2),"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10)
				dust.vsp=vsp/random_range(5,10) 
            } 
        }
	}
}

cooldown = approach(cooldown, 0, 1);

if place_meeting(x, y, oSpike) {
    instance_destroy();
}

