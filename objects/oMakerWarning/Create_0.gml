enum MESSAGE_WARNING_OPTION { CONFIRM, CANCEL, LENGTH }

text_warning = "";

current_option_index = 0;

action_on_confirm = undefined;

_mouse = object_mouse_create("Instances");

_option_base_x = GUI_W / 2;
_option_base_y = GUI_H / 1.5;
_message_warning_base_y = GUI_H / 4;

scr_inputcreate();

__play_sound_on_navigate = function() {
  audio_play_sfx(sndUiChange, false, -18.3, 1);
};

__handle_option_selection_on_input_nav_down = function() {
  var _input_nav_up = key_up or (key_up_axis_pressed and not key_axis_pressed),
      _input_nav_down = key_down or (key_down_axis_pressed and not key_axis_pressed);
  
  if _input_nav_up and current_option_index > 0 {
    __play_sound_on_navigate();
    current_option_index -= 1;
    
  }
  
  if _input_nav_down and current_option_index < MESSAGE_WARNING_OPTION.LENGTH - 1 {
    __play_sound_on_navigate();
    current_option_index += 1;
  }
};

__handle_option_activation_on_input_press = function() {
  var _input_nav_select = key_start or key_jump_pressed;
  
  if not _input_nav_select {
    return;
  }
  
  __trigger_selected_option();
};

__trigger_selected_option = function() {
  if global.settings.enable_sfx {
	  audio_play_sound(sndUiChange, 1, false, 0.20, 0, 1.4);
	}

	shake_gamepad(0.4, 2);
  
  with (oLevelMaker) {
    item_place_disable_timer.reset();
  }
  
  switch(current_option_index) {
    case MESSAGE_WARNING_OPTION.CONFIRM:
      if is_callable(action_on_confirm) {
        action_on_confirm();
      }
      instance_destroy();
    break;
    
  	case MESSAGE_WARNING_OPTION.CANCEL:
      instance_destroy();
    break;
  }
};

__get_menu_option_mouse_hovered = function() {
  for (var i = 0; i < MESSAGE_WARNING_OPTION.LENGTH; i++) {
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
  
  if current_option_index != _option_index_hovered {
    current_option_index = _option_index_hovered;
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
}

__get_option_label = function(label_index) {
  switch(label_index) {
    case MESSAGE_WARNING_OPTION.CONFIRM:
      return LANG.maker_warning_confirm;
      
    case MESSAGE_WARNING_OPTION.CANCEL:
      return LANG.maker_warning_cancel;
  }
  
  return "undefined";
};