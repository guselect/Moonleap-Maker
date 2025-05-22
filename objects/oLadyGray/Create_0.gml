levelnumb = 0;
maxspd = 0.45;

mynight=true

hsp = 0;
vsp = 0;

cx = 0;
cy = 0;

xx = 0;
yy = 0;

smove_day = sLadyNight;
sturn_day = sLadyTurn;
smove_dayB = sLadyDay;
sturn_dayB = sLadyTurnNight;

startindex = image_index;

hsp = 0.45;

if room != RoomMenu and room != RoomMenu2 {
	levelnumb = real(string_digits(room_get_name(room)))
	if levelnumb == 16 {
		levelnumb = 0;
	}
	//if levelnumb<10 {oDust.sprite_index=sDUST}
}

if image_index == 1 {
	hsp = -0.55;
}

if sign(image_xscale) == -1 {
	hsp = -0.55;
	startindex = 1;
}

image_xscale = sign(hsp);

if startindex == 0 {
	sprite_index = smove_day;
} else {
	sprite_index = smove_dayB;
}

layer=layer_get_id("Instances_2")
drawy=y

prehsp=hsp

set_pallete_index();

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