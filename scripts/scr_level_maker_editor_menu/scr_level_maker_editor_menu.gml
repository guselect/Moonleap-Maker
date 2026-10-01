function menus_get_level_editor() {
  var _menu_list = {
    main: menu_level_editor_get_main(),
    level_options: menu_level_editor_get_level_options(),
    options: menu_get_options(),
    assist: menu_get_assist(),
    soundvideo: menu_get_soundvideo(),
    deletesure: menu_get_deletesure()
  };

  return _menu_list;
}

function menu_level_editor_get_main() {
  var _menu_level_editor_main = [
    // Resume
    new MenuOptionCloseMenu(
      function() { return LANG.maker_back_to_editor; }
    ),
    
    // Level Options
    new MenuOptionMenuCall(
      function() { return LANG.maker_level_options; },
      "level_options"
    ),

    // Options
    new MenuOptionMenuCall(
      function() { return LANG.text_options; },
      "options"
    ),
    
    // Quit
    new MenuOptionActionCall(
      function() { return LANG.text_exit; },
      function() {
        menu_play_redirect_option_sound();
        room_transit(RoomMakerMenu);
      }
    )
  ];
  
  return _menu_level_editor_main;
};

function menu_level_editor_get_level_options() {
  var _option_perfect_score = new MenuOptionDirectionalToggle();
  
  _option_perfect_score.label = function(_is_toggling) {
    var _left_arrow = _is_toggling ? " < " : "";
    var _right_arrow = _is_toggling ? " >" : "";
    
    return $"{LANG.maker_perfect_score}{_left_arrow}{oLevelMaker.perfect_score}{_right_arrow}";
  };
  _option_perfect_score.toggle_left_callback = function() {
    var _perfect_score = oLevelMaker.perfect_score;
    
    _perfect_score -= 1;
    _perfect_score = clamp(_perfect_score, LEVEL_MAKER_MIN_PERFECT_SCORE, LEVEL_MAKER_MAX_PERFECT_SCORE);
    oLevelMaker.perfect_score = _perfect_score;
  };
  _option_perfect_score.toggle_right_callback = function() {
    var _perfect_score = oLevelMaker.perfect_score;
    
    _perfect_score += 1;
    _perfect_score = clamp(_perfect_score, LEVEL_MAKER_MIN_PERFECT_SCORE, LEVEL_MAKER_MAX_PERFECT_SCORE);
    oLevelMaker.perfect_score = _perfect_score;
  };
  _option_perfect_score.toggle_down_callback = function() {
    var _perfect_score = oLevelMaker.perfect_score;
    
    _perfect_score -= 10;
    _perfect_score = clamp(_perfect_score, LEVEL_MAKER_MIN_PERFECT_SCORE, LEVEL_MAKER_MAX_PERFECT_SCORE);
    oLevelMaker.perfect_score = _perfect_score;
  };
  _option_perfect_score.toggle_up_callback = function() {
    var _perfect_score = oLevelMaker.perfect_score;
    
    _perfect_score += 10;
    _perfect_score = clamp(_perfect_score, LEVEL_MAKER_MIN_PERFECT_SCORE, LEVEL_MAKER_MAX_PERFECT_SCORE);
    oLevelMaker.perfect_score = _perfect_score;
  };
  _option_perfect_score.description = function() {
    return LANG.maker_perfect_score_help;
  };
  
  var _menu_level_editor_level_options = [
    // Edit level name
    new MenuOptionCloseMenu(
      function() { return LANG.maker_edit_level_name; },
      function() { 
        var _text_input = instance_create_layer(x, y, "Instances", oTextInput);
        _text_input.user_input = oLevelMaker.level_name;
        _text_input.input_string_min = LEVEL_MAKER_LEVEL_NAME_LENGTH_MIN;
        _text_input.input_string_max = LEVEL_MAKER_LEVEL_NAME_LENGTH_MAX;
        _text_input.title = LANG.maker_edit_level_name;
        _text_input.on_finish = function(_user_input) {
          oLevelMaker.level_name = _user_input;
          menu_call_layer(menus_get_level_editor(), "level_options", "Instances", true, false, true, true);
        }
      }
    ),
    
    // Edit author name
    new MenuOptionCloseMenu(
      function() { return LANG.maker_edit_level_author; },
      function() { 
        var _text_input = instance_create_layer(x, y, "Instances", oTextInput);
        _text_input.user_input = oLevelMaker.level_author_name;
        _text_input.input_string_min = LEVEL_MAKER_LEVEL_AUTHOR_LENGTH_MIN;
        _text_input.input_string_max = LEVEL_MAKER_LEVEL_AUTHOR_LENGTH_MAX;
        _text_input.title = LANG.maker_edit_level_author;
        _text_input.on_finish = function(_user_input) {
          oLevelMaker.level_author_name = _user_input;
          menu_call_layer(menus_get_level_editor(), "level_options", "Instances", true, false, true, true);
        }
      }
    ),
    
    // Edit perfect score
    _option_perfect_score,

    // Use night music
    new MenuOptionActionCall(
      function() {
        var _night_music = oLevelMaker.use_night_music ? LANG.text_ON : LANG.text_OFF;
        
        return $"{LANG.maker_night_music}{_night_music}";
      },
      function() { 
        oLevelMaker.use_night_music = not oLevelMaker.use_night_music;
      }
    ),
    
    // Go back
    new MenuOptionMenuCall(
      function() { return LANG.text_back; },
      "main"
    ),
  ];
  
  return _menu_level_editor_level_options;
}
