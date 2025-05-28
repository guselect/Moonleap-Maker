if (key_up or (key_up_axis_pressed and !key_axis_pressed)) and (option_index != 0) {
	option_index = 0;
	play_ui_change_sound();
}

if (key_down or (key_down_axis_pressed and !key_axis_pressed)) and (option_index != 1) {
	option_index = 1;
	play_ui_change_sound();
}

if (key_start or key_jump_pressed) {
	if global.settings.enable_sfx {
	  audio_play_sound(sndUiChange, 1, false, 0.20, 0, 1.4);
	}

	shake_gamepad(0.4, 2);
	
  if option_index == 1 {
    instance_destroy();
  } else if is_callable(action_on_confirm) {
    action_on_confirm();
    instance_destroy();
  }
}