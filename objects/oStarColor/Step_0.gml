/// @description Insert description here
// You can write your code in this editor
if night=true{sprite_index=sStarDaySpike} else {sprite_index=sStarDay} 

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
