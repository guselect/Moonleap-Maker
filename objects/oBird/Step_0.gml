/// @description Insert description here
// You can write your code in this editor
if !instance_exists(oPlayer) {exit}

if point_distance(x,y,oPlayer.x,y)<39 and distance_to_point(oPlayer.x,oPlayer.y)<62
{
	if fly=false {audio_play_sfx(sfx_bird_crow,false,-14.3,7) }
	fly=true}

if fly=true
{vsp=approach(vsp,-1.5,0.05)
hsp=approach(hsp,image_xscale*3,0.025)
sprite_index=sFly}

if oPlayer.birdstuck=false
{
x+=hsp
y+=vsp
}
else
{
x+=hsp/2
y+=vsp/2
}

spark+=0.5
if spark=60
{
if instance_exists(oRoomTransition) or visible=false exit;
xx=random_range(x-6,x+6)
yy=random_range(y,y-11)
instance_create_layer(xx,yy,"Instances_2",oSparkGray)
spark=0
}

////BIRD COLLISION

if place_meeting(x,y,oPlayer) {
	audio_play_sfx(snd_warp,false,-10,5);
	instance_destroy();
	oPlayer.flash = 1;
	oPlayer.has_collected_bird = true;
	
	if room == Room58 {
		oPlayer.stars_collected = oPlayer.stars_to_collect;
	}
}
