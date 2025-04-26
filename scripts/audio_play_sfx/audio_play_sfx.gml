/// @function	audio_play_sfx(sound,loop,gain,pitch random)
function audio_play_sfx(_sound, _loop, _gain, _pitch_random) {
	if not global.settings.enable_sfx then return;

	var snd = audio_play_sound(_sound, 1, _loop, power(10, _gain / 20), 0, 1 + (random_range(-_pitch_random, _pitch_random) / 100)); 
    var _snd_string = $"{audio_get_name(_sound)}            gain:{audio_sound_get_gain(snd)}            pitch:{audio_sound_get_pitch(snd)}";

    ds_list_add(global.audio_list, _snd_string);
}

/// @function	audio_play_bgm(sound,loop,gain)
function audio_play_bgm(_sound, _loop, _gain){
	bgm = audio_play_sound(_sound, 10, _loop, power(10, _gain / 20) * global.settings.bgm_volume);

    var _bgm_string = $"BGM! {audio_get_name(_sound)}            gain:{audio_sound_get_gain(bgm)}";

	ds_list_add(global.audio_list, _bgm_string);
}
