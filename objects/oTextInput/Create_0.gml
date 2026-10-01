user_input = "";
input_string_min = 3;
input_string_max = 20;
title = "";
on_finish = -1;

state_machine = new SnowState("input");

state_machine.add("input", {
  enter: function() {
    keyboard_string = "";
  },
  step: function() {
    check_typing();
  },
  leave: function() {
    instance_destroy();
    if is_method(on_finish) {
      on_finish(user_input);
    }
    play_sound_confirm();
  }
});

state_machine.add("finish");

play_sound_bump = function() {
  audio_play_sfx(snd_bump, false, -5, 13);
};

play_sound_confirm = function() {
  var _sound = sndUiChange,
      _can_loop = false,
      _gain = -18.3,
      _pitch = 1;

  audio_play_sfx(_sound, _can_loop, _gain, _pitch);
  audio_play_sfx(sndStarGame, false, -6, 0);
};

check_typing = function() {
  var _input_length = string_length(user_input);
  
  if keyboard_check_pressed(vk_backspace) {
    if _input_length > 0 {
      user_input = string_delete(user_input, string_length(user_input), 1);
      play_sound_bump();
    }
    return;
  }
  if keyboard_check_pressed(vk_return) {
    if _input_length < input_string_min {
      play_sound_bump();
      return;
    }
    state_machine.change("finish");
  }
  if keyboard_check_pressed(vk_anykey) and string_length(user_input) >= input_string_max {
    play_sound_bump();
    keyboard_string = "";
    return;
  }
  if keyboard_string != "" {
    var _sound = snd_morcego_02,
      _can_loop = false,
      _gain = -20,
      _pitch = 13;

    audio_play_sfx(_sound, _can_loop, _gain, _pitch);
  }
  
  user_input += keyboard_string;
  keyboard_string = "";
};