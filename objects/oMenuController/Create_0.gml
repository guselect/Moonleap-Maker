/*
 * This object is a replacement for the oMenu and oPauseMenu objects.
 * 
 * To call this menu controller in the game, use menu_call(...) command or
 * instantiate it in the room and edit the variables below through the
 * Instance Creation Code.
 */ 

// Singleton object.
if instance_number(oMenuController) > 1 {
  instance_destroy();
}

menus = {};
current_menu_name = "";
fill_background = false;
show_game_version = false;
show_title = false;
is_disabled = false;
use_alt_colors = false;
on_clean_up = function() {};

_is_toggling = false;
_toggling_option_index = undefined;
_current_option_index = 0;
_background_fill_color = COLOR_NICE_BLACK;

_mouse = object_mouse_create("Instances");
_mouse.use_on_gui = not instance_exists(oIntro);

_mouse_previous_option_index = 0;

_option_base_x = GUI_W / 2;
_option_base_y = 78; // This position might change when drawing the menu. Check User Event 0.
_option_y_gap = 14;

_option_box_xoffset = 0;
_option_box_yoffset = 8;
_option_box_margin_left = 0;
_option_box_margin_top = 0;
_option_box_margin_right = 0;
_option_box_margin_bottom = 0;

scr_inputcreate();

// Change background fill color to black on space themed places.
if instance_exists(oPlayer)
and (
  (room_is(Room100) and oPlayer.y < room_height / 2)
  or instance_exists_any([oFlowerDay, oSpaceDay, oDunDay])
) {
  _background_fill_color = c_black;
}

__update_touch_controls_alpha = function() {
  obDirection.image_alpha =	global.settings.buttons / 100;
  obJump.image_alpha      =	global.settings.buttons / 100;
  oBpause.image_alpha     =	global.settings.buttons / 100;
};

__play_sound_on_navigate = function() {
  var _sound = sndUiChange,
      _can_loop = false,
      _gain = -18.3,
      _pitch = 1;

  audio_play_sfx(_sound, _can_loop, _gain, _pitch);
};

__play_sound_on_toggle_value = function() {
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

__check_debugging_mode = function() {
  var _string_match = "05081999debugmode",
      _debug_sound = sndUiChange,
      _priority = 10,
      _loop = false,
      _gain = (power(10, -18.2/20)) * (global.settings.enable_sfx),
      _offset = 0,
      _pitch = 1.4;

  if keyboard_string == _string_match and not oCamera.debug {
    oCamera.debug = true;
    audio_play_sound(_debug_sound, _priority, _loop, _gain, _offset, _pitch);
    keyboard_string = "";
  }
};

__get_title = function() {
  if room_is([RoomMenu, RoomMenu2, RoomCredits, RoomCreditsAlves, Room100, rm_blank0]) {
  	return " ";
  }

  if room_is(RoomMaker0) {
    return LANG.maker_name;
  }

  var _title = LANG[$ room_get_name(room)];
  if not is_string(_title) {
    return " ";
  }
  return _title;
};

__handle_option_selection_on_input_nav_down = function() {
  if _is_toggling {
    return;
  }
  
  var _menu = menus[$ current_menu_name],
    _options_length = array_length(_menu),
    _input_nav_up = key_up or (not key_axis_pressed and key_up_axis_pressed),
    _input_nav_down = key_down or (not key_axis_pressed and key_down_axis_pressed);
  
  if _input_nav_up and _current_option_index > 0 {
    __play_sound_on_navigate();
    _current_option_index -= 1;
    return
  }
  
  if _input_nav_down and _current_option_index < _options_length - 1 {
    __play_sound_on_navigate();
    _current_option_index += 1;
  }
};

__handle_option_activation_on_input_select_press = function() {
  var _input_nav_select = key_start or key_jump_pressed;
  
  if not _input_nav_select {
    return;
  }
  
  __trigger_selected_option();
};

__handle_option_value_toggling = function() {
  if not _is_toggling {
    _toggling_option_index = undefined;
    return;
  }
  
  var _menu = menus[$ current_menu_name],
    _option = _menu[_current_option_index],
    _input_toggle_up = key_up or (not key_axis_pressed and key_up_axis_pressed),
    _input_toggle_down = key_down or (not key_axis_pressed and key_down_axis_pressed),
    _input_toggle_left = key_left_pressed or (not key_axis_pressed and key_left_axis_pressed) or mouse_wheel_up(),
    _input_toggle_right = key_right_pressed or (not key_axis_pressed and key_right_axis_pressed) or mouse_wheel_down();
  
  if _input_toggle_left and is_method(_option.toggle_left_callback) {
    __play_sound_on_toggle_value();
    _option.toggle_left_callback();
    return;
  }
  
  if _input_toggle_right and is_method(_option.toggle_right_callback) {
    __play_sound_on_toggle_value();
    _option.toggle_right_callback();
    return;
  }
  
  if _input_toggle_up and is_method(_option.toggle_up_callback) {
    __play_sound_on_toggle_value();
    _option.toggle_up_callback();
    return;
  }
  
  if _input_toggle_down and is_method(_option.toggle_down_callback) {
    __play_sound_on_toggle_value();
    _option.toggle_down_callback();
    return
  }
};

__handle_option_selection_on_mouse_hover = function() {
  if _mouse.is_hidden() {
    return;
  }
  
  var _option_index_hovered = __get_menu_option_mouse_hovered();
  
  if is_undefined(_option_index_hovered) {
    _mouse.cursor_type = MENU_CURSOR_TYPE.POINTER;
    return;
  }
  
  if _is_toggling {
    _mouse.cursor_type = _toggling_option_index == _option_index_hovered ?
      MENU_CURSOR_TYPE.FINGER
      : MENU_CURSOR_TYPE.POINTER;
    return;
  }
  
  _mouse.cursor_type = MENU_CURSOR_TYPE.FINGER;
      
  if _current_option_index != _option_index_hovered {
    _current_option_index = _option_index_hovered;
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

__get_menu_option_mouse_hovered = function() {
  var _menu = menus[$ current_menu_name],
      _options_length = array_length(_menu);
  
  for (var i = 0; i < _options_length; i++) {
    var _option = _menu[i],
        _x = _option_base_x + _option_box_xoffset,
        _y = _option_base_y + _option_box_yoffset + (_option_y_gap * i),
        _label = _is_toggling ? _option.get_label(_is_toggling) : _option.get_label(),
        _width = string_width(_label),
        _height = string_height(_label),
        
        _x1 = _x - (_width div 2) + _option_box_margin_left,
        _y1 = _y - (_height div 2) + _option_box_margin_top,
        _x2 = _x + (_width div 2) - _option_box_margin_right,
        _y2 = _y + (_height div 2) - _option_box_margin_bottom;
    
    if _mouse.is_into_rect_area(_x1, _y1, _x2, _y2) {
      return i;
    }
  }
  
  return undefined;
};

__trigger_selected_option = function() {
  var _menu = menus[$ current_menu_name],
    _option = _menu[_current_option_index];
  
  if _option.can_play_select_sound {
    __play_sound_on_select_option();
  }

  var _shake_intensity = 0.4,
      _shake_duration = 2;

  shake_gamepad(_shake_intensity, _shake_duration);
  
  // Check which type of option is to trigger the right command flow.
  if is_instanceof(_option, MenuOptionMenuCall) {
    var _menu_name = _option.menu_name;

    if struct_exists(menus, _menu_name) {
      current_menu_name = _menu_name;
      _current_option_index = 0;
      _option.run_action();
    }
  } else if is_instanceof(_option, MenuOptionCloseMenu) {
    _option.run_action();
    instance_destroy();
  } else if is_instanceof(_option, MenuOptionActionCall) {
    _option.run_action();
  } else if is_instanceof(_option, MenuOptionDirectionalToggle) {
    _is_toggling = not _is_toggling;
    if _toggling_option_index != _current_option_index {
      _toggling_option_index = _current_option_index;
    }
  }
};

__update_touch_controls_alpha();