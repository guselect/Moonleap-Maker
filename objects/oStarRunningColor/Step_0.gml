/// @description Insert description here
// You can write your code in this editor
on_ground_var = has_collided(0, 1, true, [oPermaSpike]);
if not on_ground_var and image_angle == 0 {
	vsp += 0.125
}
if vsp > 4 {
	vsp = 4
}

if y>room_height{y-=180}
if x>room_width{x-=320}
if y<0{y+=180}
if x<0{x+=320}

hsp=0
if !instance_exists(oPlayer) {exit;}

if night=false
{
	sprite_index=sStarDayRun
	if distance_to_point(x,oPlayer.y)<10
	{
	if distance_to_point(oPlayer.x,oPlayer.y)<40
	{
		if oPlayer.x>x {hsp=-1} else {hsp=1}
	}

	if distance_to_point(oPlayer.x-320,oPlayer.y)<40
	{
		if oPlayer.x-320>x {hsp=-1} else {hsp=1}
	}

	if distance_to_point(oPlayer.x+320,oPlayer.y)<40
	{
		if oPlayer.x+320>x {hsp=-1} else {hsp=1}
	}
	}
}
else
{
	
	sprite_index=sStarDaySpikeRun
	if distance_to_point(x,oPlayer.y)<32
	{
		
	if distance_to_point(oPlayer.x,oPlayer.y)<128
	{
		if oPlayer.x<x {hsp=-1.125} else {hsp=1.125}
	}

	if distance_to_point(oPlayer.x-320,oPlayer.y)<128
	{
		if oPlayer.x-320<x {hsp=-1.25} else {hsp=1.125}
	}

	if distance_to_point(oPlayer.x+320,oPlayer.y)<128
	{
		if oPlayer.x+320<x {hsp=-1.125} else {hsp=1.125}
	}
	}
	
	if instance_exists(oPlayer)
	{if distance_to_object(oPlayer)<4 {instance_destroy(oPlayer)}}
}

if hsp>0 and !(place_meeting(x-(sprite_width/3),y+1,oSolid) or place_meeting(x-(sprite_width/3),y+1,oPlatGhost) or place_meeting(x-(sprite_width/3),y+1,oPermaSpike))
	{image_xscale=-image_xscale hsp=0}																					    											  
																															   												 
if hsp<0 and !(place_meeting(x-(sprite_width/3),y+1,oSolid) or place_meeting(x-(sprite_width/3),y+1,oPlatGhost) or place_meeting(x-(sprite_width/3),y+1,oPermaSpike))
	{image_xscale=-image_xscale hsp=0}
	
if place_meeting(x+hsp,y,oSolid)
	{image_xscale=-image_xscale hsp=0}
	

if y>room_height{y-=180}
if x>room_width{x-=320}
if y<0{y+=180}
if x<0{x+=320}

if hsp!=0 {image_xscale=sign(hsp) image_speed=4} else {image_speed=1 }

