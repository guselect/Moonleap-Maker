hsp = 0;
vsp = 0;

dir = image_xscale;
drawhsp = image_xscale;
image_xscale = 1;

hsp = image_index == 1 ? 0.5 : -0.5;
startindex = image_index;
night = false;
early_night = false;

cx = 0;
cy = 0;

layer = layer_get_id("Instances_2");
drawy = y;

prehsp = hsp;

xx = x;
yy = y;

change = false
palette_index = 4;

image_index = 0;

set_pallete_index();

play_mushroom_sound = function() {
	if audio_is_playing_any([snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04]) then return;
	
	var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
				
	audio_play_sfx(sfxcogu, false, -16, 2);
}

//spawn_dust_particles = function() {
//	repeat(irandom_range(3, 5)) {
//		var dust = instance_create_layer(x - (sprite_width / 2), y + (sprite_width / 2), "Instances_2", oBigDust);
//		dust.hsp = hsp / random_range(5, 10);
//		dust.vsp = vsp / random_range(5, 10);
//	}
//}