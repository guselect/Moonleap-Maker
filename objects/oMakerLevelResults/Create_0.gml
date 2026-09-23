enum LEVEL_MAKER_RESULT_OPTION { TRY_AGAIN, QUIT, LENGTH }

level_name = "";
level_author = "";
player_score = 0;
perfect_score = 0;
time_played = -1;
record_time = -1;

current_option = 0;

_mouse = object_mouse_create("Instances");
_mouse.use_on_gui = true;

_option_base_x = GUI_W / 2;
_option_base_y = GUI_H / 1.35;

scr_inputcreate();

__rank_get_result_letter = function() {
  var _letter = "D";
  
  if player_score <= perfect_score + 9 {
    _letter = "C";
  }
  if player_score <= perfect_score + 6 {
    _letter = "B";
  }
  if player_score <= perfect_score + 3 {
    _letter = "A";
  }
  if player_score <= perfect_score {
    _letter = "S";
  }
  if instance_exists(oBird) {
    _letter = "D";
  }
  
  return _letter;
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
  audio_play_sfx(sndStarGame, false, -6, 0);
};

__handle_option_selection_on_input_nav = function() {
  var _input_nav_up = key_up or (not key_axis_pressed and key_up_axis_pressed),
      _input_nav_down = key_down or (not key_axis_pressed and key_down_axis_pressed);
  
  if _input_nav_down and current_option == LEVEL_MAKER_RESULT_OPTION.TRY_AGAIN {
    __play_sound_on_navigate();
    current_option += 1;
    return;
  }
  
  if _input_nav_up and current_option == LEVEL_MAKER_RESULT_OPTION.QUIT {
    __play_sound_on_navigate();
    current_option -= 1;
    return;
  }
};

__handle_option_activation_on_input_press = function() {
  var _input_nav_select = key_jump or key_start;
  
  if not _input_nav_select {
    return;
  }
  
  __trigger_selected_option();
};

__trigger_selected_option = function() {
  switch(current_option) {
    case LEVEL_MAKER_RESULT_OPTION.TRY_AGAIN:
      var _maker_transition = maker_transition_start(room);
      
      __play_sound_on_select_option();
      
      _maker_transition.on_end_fade_out = function() {
        oLevelMaker.time_played_timer.reset();
        oLevelMaker.reset_level();
        instance_destroy(oMakerLevelResults);
      };
    break;
  
    case LEVEL_MAKER_RESULT_OPTION.QUIT:
      __play_sound_on_select_option();
      room_transit(RoomMakerMenu, "Instances");
    break;
  }
};

__get_menu_option_mouse_hovered = function() {
  for (var i = 0; i < LEVEL_MAKER_RESULT_OPTION.LENGTH; i++) {
    var _option_label = __get_option_label(i),
        _option_label_width = string_width(_option_label),
        _option_label_height = string_height(_option_label),
        _option_half_width = _option_label_width / 2,
        _option_half_height = _option_label_height / 2,
        _option_x = _option_base_x,
        _option_y = _option_base_y + _option_label_height * i,
        
        _option_box_left = _option_x - _option_half_width,
        _option_box_top = _option_y - _option_half_height,
        _option_box_right = _option_x + _option_half_width,
        _option_box_bottom = _option_y + _option_half_height;
    
    if _mouse.is_into_rect_area(
      _option_box_left,
      _option_box_top,
      _option_box_right,
      _option_box_bottom
    ) {
      return i;
    }
  }
  
  return undefined;
};

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
};

__update_mouse_cursor_type = function() {
  var _option_index_hovered = __get_menu_option_mouse_hovered();
  
  _mouse.cursor_type = MENU_CURSOR_TYPE.POINTER;

  if is_undefined(_option_index_hovered) {
    return;
  }
  
  _mouse.cursor_type = MENU_CURSOR_TYPE.FINGER;  
};

__get_option_label = function(label_index) {
  switch(label_index) {
    case LEVEL_MAKER_RESULT_OPTION.TRY_AGAIN:
      return LANG.maker_level_try_again;
  
    case LEVEL_MAKER_RESULT_OPTION.QUIT:
      return LANG.text_exit;
  }
  
  return "undefined";
};