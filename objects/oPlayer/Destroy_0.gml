

var sfxdeath = choose(
    sfx_luano_death_pause_01,
    sfx_luano_death_pause_02,
    sfx_luano_death_pause_03,
    sfx_luano_death_pause_04,
    sfx_luano_death_pause_05
);

audio_play_sfx(sfxdeath, false, -8.79, 5);

if instance_exists(oTimeAttack) {
    oTimeAttack.hearts -= 1;
} 
	
if oCamera.current_skin == 5 {
    PlayerDead = not oCamera.night ? sPlayerDead5 : sPlayerDead6;
}

oCamera.deathcount += 1;

var _dead_player = instance_create_layer(x, y, layer, oDead);
_dead_player.sprite_index = PlayerDead;
_dead_player.image_xscale = image_xscale;
_dead_player.night = night;
_dead_player.trueblack = trueblack;
_dead_player.neutral = neutral;

if oCamera.current_skin == 1 or oCamera.current_skin == 6 {
	_dead_player.visible = false;
    _dead_player.current_skin = 1;
	_dead_player.sprite_index = sPlayerDead1;
    
	repeat(3) {
        instance_create_layer(x, y, "Instances_2", oBigSmoke);
    }

	audio_play_sfx(snd_kick, false, -7.3, 13);
}