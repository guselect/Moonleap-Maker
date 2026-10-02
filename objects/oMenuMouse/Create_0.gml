cursor_type = MENU_CURSOR_TYPE.POINTER;

use_on_gui = true;

xx = 0;
yy = 0;
xxprevious = 0;
yyprevious = 0;

_mouse_screen_time_frames_max = 240;
_mouse_screen_time_frames = _mouse_screen_time_frames_max;

/// @desc This function checks whether the mouse is hidden by visible being `false` or not moving for too long.
is_hidden = function() {
  return _mouse_screen_time_frames == 0 or not visible;
}

/// @desc This function checks whether the mouse position is into the given rectangle area.
/// @param {real} left The position at the left side of the rectangle area.
/// @param {real} top The position at the top side of the rectangle area.
/// @param {real} right The position at the right side of the rectangle area.
/// @param {real} bottom The position at the bottom side of the rectangle area.
is_into_rect_area = function(left, top, right, bottom) {
  return xx >= left and xx <= right and yy >= top and yy <= bottom;
};

__has_moved = function() {
  return (xx != xxprevious or yy != yyprevious);
};

__update_mouse_position = function() {
  if use_on_gui {
    xx = device_mouse_x_to_gui(0);
    yy = device_mouse_y_to_gui(0);
    return;
  }
  
  xx = mouse_x;
  yy = mouse_y;
};


__update_mouse_previous_position = function() {
  if not __has_moved() {
    return;
  }

  xxprevious = xx;
  yyprevious = yy;
};

__count_mouse_screen_time = function() {
  if __has_moved() or mouse_check_button(mb_any) or mouse_wheel_down() or mouse_wheel_up() {
    _mouse_screen_time_frames = _mouse_screen_time_frames_max;
    return;
  }
  _mouse_screen_time_frames = max(0, _mouse_screen_time_frames - 1);
};

__update_mouse_position();