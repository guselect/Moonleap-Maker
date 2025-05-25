scr_inputget()

update_menu_title();

wavevar=floor(wave(-1,1,current_time/1000))

if (key_up or (key_up_axis_pressed and !key_axis_pressed)) and (option_index > 0) {
	option_index -= 1;
	audio_play_sfx(sndUiChange,false,-18.3,1);
}

if (key_down or (key_down_axis_pressed and !key_axis_pressed)) and (option_index < (array_length(menu)-1)) {
	option_index += 1;
	audio_play_sfx(sndUiChange,false,-18.3,1);
}

option = menu[option_index];

if (key_start or key_jump_pressed) {
	if global.settings.enable_sfx {
	  audio_play_sound(sndUiChange,1,false,0.20,0,1.4);
	}
	shake_gamepad(0.4, 2);
	var _action = method(id, option.action);
	_action(); //run the action for the currently selected option
}

oCamera.pause_delay = 10;
