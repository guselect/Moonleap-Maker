/// @description Insert description here
// You can write your code in this editor

if y>room_height{
	y-=180
	yy-=176;
}
if x>room_width{x-=320}
if y<0 {
	y+=180;
	yy+=176;
}
if x<0{x+=320}

if has_collided(0, sign(vsp), true, [oPermaSpike]) {
	dir *= -1;
}
//if place_meeting(x, y + 1, oSolid) or place_meeting(x, y + 1, oSpike) or (place_meeting(x, y + 1, oPlatGhost) && !place_meeting(x, y, oPlatGhost))
//{dir=-1}
//if place_meeting(x,y - 1,oSolid)  or place_meeting(x, y - 1, oPlatGhostInv) 
//{dir= 1} 

if dir == 1 {
	if y < yy {
		vsp += 0.1;
	} else {
		vsp = 0;
	}
	sprite_index = sBatDown;
}

if dir == -1 {
	if y > yy {
		vsp -= 0.1;
	} else {
		vsp = 0;
	}
	sprite_index = sBatUp;
}

vsp = clamp(vsp, -1, 1);

if vsp == 0 {
	image_speed = 1;
} else {
	image_speed = 3;
} 