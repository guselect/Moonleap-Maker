enum ORB_MODE { NORMAL, NEUTRAL };

night = true;
ani = 0;
hsp = 0;
vsp = 0;
grav = 0.125;
hsp_plus = 0;
flash = 0;
scare = false;
mode = ORB_MODE.NORMAL;
colapproach = 0;

change = false;

jumped = false;
landed = false;

platform_target = 0;
wall_target     = 0;

on_ground_var = has_collided(0, 1);

// Used for sub-pixel movement
cx = 0;
cy = 0;
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

if not audio_is_playing(sndPush) {
    audio_play_sfx(sndPush,true,-17,0)
}