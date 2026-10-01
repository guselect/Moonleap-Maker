messages = [];
message_index = 0;
current_message = "";

message_color = COLOR_NICE_WHITE;
bg_color = COLOR_NICE_BLACK;

_mouse = object_mouse_create("Instances");

_close_option_x = GUI_W / 2;
_close_option_y = GUI_H - 20;

scr_inputcreate();

__play_sound_on_change_page = function() {
  audio_play_sfx(sndUiChange, false, -18.3, 1);
};

__handle_page_navigation = function() {
  var _messages_length = array_length(messages);
  
  if _messages_length <= 1 {
    return;
  }
  
  var _input_nav_right = key_right_pressed or (key_right_axis_pressed and not key_axis_pressed) or mouse_wheel_down(),
      _input_nav_left = key_left_pressed or (key_left_axis_pressed and not key_axis_pressed) or mouse_wheel_up();
  
  if _input_nav_right and message_index < _messages_length - 1 {
    __play_sound_on_change_page();
    message_index += 1;
    return;
  }
  
  if _input_nav_left and message_index > 0 {
    __play_sound_on_change_page();
    message_index -= 1;
  }
};

__handle_info_quit_on_input_press = function() {
  var _input_press = key_jump_pressed or key_start;
  
  if not _input_press {
    return;
  }
  
  __trigger_quit_info();
};

__handle_info_quit_on_mouse_click = function() {
  if not instance_exists(_mouse) {
    return;
  }
  
  if _mouse.is_hidden() {
    return;
  }
  
  if not mouse_check_button_pressed(mb_left) {
    return;
  }
  
  __trigger_quit_info();
}

__trigger_quit_info = function() {
  __play_sound_on_change_page();
  
  with (oLevelMaker) {
    item_place_disable_timer.reset();
  }
  
  instance_destroy();
};

__get_close_option_label = function() {
  return LANG.text_back;
};

__update_mouse_cursor_type = function() {
  if not instance_exists(_mouse) {
    return;
  }
  
  _mouse.cursor_type = MENU_CURSOR_TYPE.FINGER;
}
