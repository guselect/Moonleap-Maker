/// @description Insert description here
// You can write your code in this editor
night=true
ani=0
hsp=0
vsp=0
grav=0.125
hsp_plus=0
flash=0
scare=false

colapproach=0
if !audio_is_playing(sndPush){audio_play_sfx(sndPush,true,-17,0)}

change=false
// new movement code

jumped = false;
landed = false;

platform_target = 0;
wall_target     = 0;

on_ground_var = has_collided(0, 1);

// Used for sub-pixel movement
cx = 0;
cy = 0;

c_left    = place_meeting(x - 1, y, oSolid);
c_right   = place_meeting(x + 1, y, oSolid);
sticking = false

cooldown = 0;
trueblack = false;

if instance_exists(oLevelMaker) {
	switch(oLevelMaker.selected_style) {
		case LEVEL_STYLE.FLOWERS:
		case LEVEL_STYLE.SPACE:
		case LEVEL_STYLE.DUNGEON:
			trueblack = true; break;
	}
} else if instance_exists(oFlowerDay) or instance_exists(oSpaceDay) or instance_exists(oDunDay) {
	trueblack = true;
}

if instance_exists(oNeutralFlag) {
	neutral = true;
}