/// @description Insert description here
// You can write your code in this editor
sindex=sprite_index
iindex=image_index
xindex=image_xscale
levelnumb=0
hsp_plus=0

if room!=RoomMenu and room!=RoomMenu2
{
levelnumb=real(string_digits(room_get_name(room)))
if levelnumb=16 {levelnumb=0}

//if levelnumb<10 {oDust.sprite_index=sDUST}
}

numb=0
night=false
ani=0
hsp=-(image_xscale*0.55)
vsp=0
grav=0.125
turn=false

idlesprite=sSnailIdle
walksprite=sSnailWalk

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

palette_index = 0;

if instance_exists(oGrassDay) {
	palette_index = 0;
} else if instance_exists(oCloudDay) {
	palette_index = 1;	
} else if instance_exists(oFlowerDay) {
	palette_index = 2;
} else if instance_exists(oSpaceDay) {
	palette_index = 3;
} else if instance_exists(oDunDay) {
	palette_index = 4;
}

is_stuck = function() {
	return has_collided(2, 0) and has_collided(-2, 0);
}

play_mushroom_sound = function() {
	if audio_is_playing_any([snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04]) then return;
	
	var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
				
	audio_play_sfx(sfxcogu, false, -16, 2);
}

spawn_dust_particles = function() {
	repeat(irandom_range(3, 5)) {
		var dust = instance_create_layer(x - (sprite_width / 2), y + (sprite_width / 2), "Instances_2", oBigDust);
		dust.hsp = hsp / random_range(5, 10);
		dust.vsp = vsp / random_range(5, 10);
	}
}