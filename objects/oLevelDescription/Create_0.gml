enum LEVEL_MAKER_DESCRIPTION_OPTION { PLAY, EDIT, DELETE, GO_BACK, LENGTH }

scr_inputcreate();

level = undefined;

current_option = 0;
confirm_erase_count = 0;
confirm_erase_count_max = 3;

_mouse = object_mouse_create("Instances");

// =================================
// UI variables
// =================================
_box_sprite = sLevelDescriptionBox;
_box_frame = 0;
_box_left = 25;
_box_top = 20;
_box_width = GUI_W - _box_left * 2;
_box_height = GUI_H - _box_top * 2;

_text_height = font_get_size(oCamera.font) * 2.4;

_option_x = GUI_W / 2;
_option_y = _box_height - sprite_get_height(_box_sprite) - _text_height * 2;


__play_transition_sound = function() {
  menu_play_redirect_option_sound();
};

__play_sound_on_navigate = function() {
  var _sound = sndUiChange,
      _can_loop = false,
      _gain = -18.3,
      _pitch = 1;

  audio_play_sfx(_sound, _can_loop, _gain, _pitch);
};

__play_sound_on_select_option = function() {
  var _ui_select_sound = sndUiChange,
      _priority = 1,
      _loop = false,
      _gain = 0.20 * (global.settings.enable_sfx),
      _offset = 0,
      _pitch = 1.4;

  audio_play_sound(_ui_select_sound, _priority, _loop, _gain, _offset, _pitch);
};

__get_menu_option_mouse_hovered = function() {
  for (var i = 0; i < LEVEL_MAKER_DESCRIPTION_OPTION.LENGTH; i++) {
    var _option_label = __get_option_label(i),
        _option_half_width = string_width(_option_label) / 2,
        _option_half_height = string_height(_option_label) / 2,
        
        _option_left = _option_x - _option_half_width,
        _option_top = _option_y - _option_half_height + (i * _text_height),
        _option_right = _option_x + _option_half_width,
        _option_bottom = _option_y + _option_half_height + (i * _text_height);
    
    if _mouse.is_into_rect_area(
      _option_left,
      _option_top,
      _option_right,
      _option_bottom
    ) {
      return i;
    }
  }
  
  return undefined;
};

__handle_option_selection_on_input_nav_down = function() {
  var _input_nav_up = key_up or (key_up_axis_pressed and not key_axis_pressed),
      _input_nav_down = key_down or (key_down_axis_pressed and not key_axis_pressed);

  if _input_nav_up and current_option > 0 {
    __play_sound_on_navigate();
    current_option -= 1;
    confirm_erase_count = 0;
    return;
  } 

  if _input_nav_down and current_option < LEVEL_MAKER_DESCRIPTION_OPTION.LENGTH - 1 {
    __play_sound_on_navigate();
    current_option += 1;
    confirm_erase_count = 0;
    return;
  }
};

__handle_option_activation_on_input_select_press = function() {
  var _input_nav_select = key_start or key_jump_pressed;
  
  if not _input_nav_select {
    return;
  }
  
  __trigger_selected_option();
};

__trigger_selected_option = function() {
  __play_sound_on_select_option();
    
  var _shake_intensity = 0.4,
      _shake_duration = 2;
  
  shake_gamepad(_shake_intensity, _shake_duration);
  
  switch(current_option) {
    // Play
    case LEVEL_MAKER_DESCRIPTION_OPTION.PLAY:
      __play_transition_sound();
      var _data_trasition = instance_create_layer(-16, -16, "Instances", oMakerLevelDataTransition),
          _transition_title = level.name,
          _transition_subtitle = level.author;
      
      _data_trasition.level_filename = level.filename;
      _data_trasition.is_true_test = true;
      
      var _transition = maker_transition_start(
        RoomMaker0,
        _transition_title,
        _transition_subtitle,
      );
    break;
      
    // Edit
    case LEVEL_MAKER_DESCRIPTION_OPTION.EDIT:
      __play_transition_sound();
      var _data_edit_trasition = instance_create_layer(-16, -16, "Instances", oMakerLevelDataTransition);
      
      _data_edit_trasition.level_filename = level.filename;
      _data_edit_trasition.is_true_test = false;
      
      maker_transition_start(RoomMaker0);
    break;
  
    // Erase
    case LEVEL_MAKER_DESCRIPTION_OPTION.DELETE:
      confirm_erase_count += 1;
      if confirm_erase_count < confirm_erase_count_max {
        break;
      }
      if file_exists(level.filename) {
        file_delete(level.filename);  
      }
      var _sfx_death = choose(
          sfx_luano_death_pause_01,
          sfx_luano_death_pause_02,
          sfx_luano_death_pause_03,
          sfx_luano_death_pause_04,
          sfx_luano_death_pause_05
        ),
          _loop = false,
          _gain = -8.79,
          _pitch_random = 5;
  
      audio_play_sfx(_sfx_death, _loop, _gain, _pitch_random);
      
      if instance_exists(oMakerLevelsList) {
        oMakerLevelsList.import_levels_from_levels_folder();
        oMakerLevelsList.current_level_index = -2;
      }
      instance_destroy();
    break;
  
    // Go back
    case LEVEL_MAKER_DESCRIPTION_OPTION.GO_BACK:
      instance_destroy();
    break;
  }
}

__handle_option_selection_on_mouse_hover = function() {
  if _mouse.is_hidden() {
    return;
  }
  
  var _option_index_hovered = __get_menu_option_mouse_hovered();
  
  if is_undefined(_option_index_hovered) {
    return;
  }
  
  if current_option != _option_index_hovered {
    current_option = _option_index_hovered;
    __play_sound_on_navigate();
  }
};

__handle_option_activation_on_mouse_click = function() {
  if not instance_exists(_mouse) {
    return;
  }
  
  if _mouse.is_hidden() {
    return;
  }
  
  if not mouse_check_button_pressed(mb_left) {
    return;
  }
  
  var _option_index_hovered = __get_menu_option_mouse_hovered();
  
  if is_undefined(_option_index_hovered) {
    return;
  }
  
  __trigger_selected_option();
}

__update_mouse_cursor_type = function() {
  var _option_index_hovered = __get_menu_option_mouse_hovered();
  
  _mouse.cursor_type = MENU_CURSOR_TYPE.POINTER;
  
  if not is_undefined(_option_index_hovered) {
    _mouse.cursor_type = MENU_CURSOR_TYPE.FINGER;  
    return;
  }
}

__level_get_rank_letter = function(_player_score, _perfect_score) {
  var _letter = "D";
  
  if _player_score <= _perfect_score + 9 {
    _letter = "C";
  }
  if _player_score <= _perfect_score + 6 {
    _letter = "B";
  }
  if _player_score <= _perfect_score + 3 {
    _letter = "A";
  }
  if _player_score <= _perfect_score {
    _letter = "#S#";
  }
  if _player_score < 0 {
    _letter = "-";
  }
  
  return _letter;
};

__get_option_label = function(label_index) {
  switch(label_index) {
    case LEVEL_MAKER_DESCRIPTION_OPTION.PLAY: 
      return LANG.maker_menu_play;
  
    case LEVEL_MAKER_DESCRIPTION_OPTION.EDIT:
      return LANG.maker_menu_edit;
  
    case LEVEL_MAKER_DESCRIPTION_OPTION.DELETE:
      if confirm_erase_count > 0 {
        return $"{LANG.maker_menu_level_erase} ({confirm_erase_count}/{confirm_erase_count_max})";
      }
      return LANG.maker_menu_level_erase;
  
    case LEVEL_MAKER_DESCRIPTION_OPTION.GO_BACK:
      return LANG.text_back;
  }
  
  return "undefined";
}

layer = layer_get_id("Instances_2");
