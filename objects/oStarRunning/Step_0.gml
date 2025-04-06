/// @description Insert description here
// You can write your code in this editor
on_ground_var= has_collided(0, 1) or place_meeting(x, y + 1, oPermaSpike)
if on_ground_var=false {vsp+=0.125}
if vsp>4 {vsp=4}

if y>room_height{y-=180}
if x>room_width{x-=320}
if y<0{y+=180}
if x<0{x+=320}

hsp=0
if !instance_exists(oPlayer) {exit;}



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

if hsp>0 and !(place_meeting(x-(sprite_width/3),y+1,oSolid) or place_meeting(x-(sprite_width/3),y+1,oPlatGhost))
	{image_xscale=-image_xscale hsp=0}

if hsp<0 and !(place_meeting(x-(sprite_width/3),y+1,oSolid) or place_meeting(x-(sprite_width/3),y+1,oPlatGhost))
	{image_xscale=-image_xscale hsp=0}
	
if place_meeting(x+hsp,y,oSolid)
	{image_xscale=-image_xscale hsp=0}
	

if y>room_height{y-=180}
if x>room_width{x-=320}
if y<0{y+=180}
if x<0{x+=320}

if hsp!=0
{
	image_xscale=hsp image_speed=4
	} else {image_speed=1 }
	
	