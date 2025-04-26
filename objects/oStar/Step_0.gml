on_ground_var = has_collided(0, 1, true, [oPermaSpike]);

if not on_ground_var and image_angle == 0 {
	vsp += 0.125;
}

if vsp > 4 {
	vsp = 4;
}

object_set_room_wrapping();
//if y>room_height{y-=180}
//if x>room_width{x-=320}
//if y<0{y+=180}
//if x<0{x+=320}

//if instance_exists(snail)
//{
//	if snail != noone
//	{
//		x=snail.x
//		y=snail.y-8
//		image_xscale=snail.image_xscale
//		sprite_index=sStarAlive
//		exit
//	}
//}

//if bat!=noone
//{
//	if (place_meeting(x, y + 1, bat) && !place_meeting(x, y, bat)) {
//		x = bat.x - 8;
//	}
//}


//if batver!=noone
//{
//	if  place_meeting(x, y + 1, batver) {
//		y = batver.y - 24;
//	}
//}

if place_meeting(x, y, oSolid) 
and not place_meeting(x, y, [oSnail, oSnailNight, oSnailGray, oBat, oBatGiant, oBatSuperGiant, oBatVer, oLady, oLadyGiant, oLadyGiant4, oLadyVer]) {
	repeat(irandom_range(2, 4)) {
		instance_create_layer(x,y,"Instances_2",oBigSmoke);
	}
	audio_play_sfx(snd_kick,false,-7.3,13)
	instance_destroy();
}