/// @desc This function displays a popup message on screen about the missing requirements for the player to test or save the level.
/// @param {bool} is_save_mode When `true`, the message about the missing requirements will be related to "saving the level". Default: `false`.
function message_popup_call_level_requirements(is_save_mode = false) {
  var _msg = "",
      _msg_count = 0, // used to add line break.
      _duration = 150;
  
  if not oLevelMaker.has_level_a_player() {
    if is_save_mode {
      _msg += $"- {LANG.maker_level_save_no_player}";
    } else {
      _msg += $"- {LANG.maker_level_test_no_player}";  
    }
    _msg_count += 1;
  }
  
  if not oLevelMaker.has_level_a_star() {
    if _msg_count > 0 {
      _msg += "\n";
      _duration += 40;
    }
    if is_save_mode {
      _msg += $"- {LANG.maker_level_save_no_star}";
    } else {
      _msg += $"- {LANG.maker_level_test_no_star}";  
    }
  }
  
  audio_play_sfx(snd_bump, false, -5, 13);
  call_message_popup(_msg, _duration, layer);
}
