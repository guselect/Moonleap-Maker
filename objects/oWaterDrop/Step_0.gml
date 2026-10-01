/// @description Insert description here
// You can write your code in this editor


vis+=1
if vis>4 {vis=1}

vsp+=grav
if vsp>3 {vsp=3}
y+=vsp

if instance_exists(oBack) {
  image_index = oBack.image_index;
} else if instance_exists(oLevelMaker)
and instance_exists(oPlayer) {
  image_index = real(oPlayer.night);
}

if vis=1 or vis=2
{
	if place_meeting(x,y,oSolid) or place_meeting(x,y,oSpike)  {instance_destroy()}
	visible=true
}