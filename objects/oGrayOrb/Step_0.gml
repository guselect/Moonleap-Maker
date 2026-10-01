if not instance_exists(oPlayer) then exit;

on_ground_var = has_collided(0, 1) or place_meeting(x, y + 1, oPermaSpike);

if instance_exists(oPlayer)
{
	if place_meeting(x-2,y,oPlayer)
	{if oPlayer.hsp>0 {hsp=oPlayer.hsp}}

	if place_meeting(x+2,y,oPlayer)
	{if oPlayer.hsp<0 {hsp=oPlayer.hsp}}
	
	if !(place_meeting(x-2,y,oPlayer) or place_meeting(x+2,y,oPlayer))
	{hsp=approach(hsp,0,0.05)}
}
if hsp!=0  {if random_range(0,2)>1 {instance_create_layer(x,y+8,layer,oBigDust)}}


object_set_room_wrapping();

if not on_ground_var {
  vsp += v_grav;
}

vsp = min(vsp, v_max_fall);

if place_meeting(x, y, oSpike) {
  instance_destroy();
}
