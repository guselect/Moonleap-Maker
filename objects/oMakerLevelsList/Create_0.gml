enum LEVELS_ORDERBY {
  NAME_ASC,
  NAME_DESC,
  AUTHOR_ASC,
  AUTHOR_DESC,
  RANK_ASC,
  RANK_DESC,
  LENGTH
}

levels = [];
current_level_index = 0;

levels_to_display = 3;
level_display_range_start = 0;
level_display_range_end = levels_to_display - 1;

levels_orderby = LEVELS_ORDERBY.NAME_ASC;

input_delay_frames = 0;
input_delay_frames_max = 5;

_mouse = object_mouse_create("Instances");

_option_index_minimum = -2;

_option_index_goback = -2;
_option_index_orderby = -1;

// =================================
// UI variables
// =================================
__get_option_label_goback_text = function() {
  return LANG.text_back;
};

__get_option_label_orderby_text = function() {
  return $"{LANG.maker_orderby}{__orderby_option_get_text()}";
};

_text_margin_top = 8;
_text_margin_left = 16;
_text_margin_right = 16;
_text_padding_left = 6;
_text_padding_top = 2;
_text_padding_right = 6;

_option_label_goback_x = GUI_W - _text_margin_right;
_option_label_goback_y = _text_margin_top;

_option_label_orderby_x = GUI_W - _text_margin_right;
_option_label_orderby_y = _text_margin_top;

_menu_start_x = 8;
_menu_start_y = 48;

_box_sprite = sLevelBox;
_box_margin_left = 8;
_box_margin_right = 16;
_box_margin_bottom = 4;
_box_width = GUI_W - _menu_start_x - _box_margin_left - _box_margin_right;
_box_height = 40;

_scroll_arrow_up_sprite = sLevelScrollArrowUp;
_scroll_arrow_up_sprite_width = sprite_get_width(_scroll_arrow_up_sprite);
_scroll_arrow_up_sprite_height = sprite_get_height(_scroll_arrow_up_sprite);
_scroll_arrow_up_margin_right = 3;
_scroll_arrow_up_x = GUI_W - _scroll_arrow_up_sprite_width - _scroll_arrow_up_margin_right;
_scroll_arrow_up_y = _menu_start_y;

_scroll_arrow_down_sprite = sLevelScrollArrowDown;
_scroll_arrow_down_sprite_width = sprite_get_width(_scroll_arrow_down_sprite);
_scroll_arrow_down_sprite_height = sprite_get_height(_scroll_arrow_down_sprite);
_scroll_arrow_down_margin_right = 3;
_scroll_arrow_down_x = GUI_W - _scroll_arrow_down_sprite_width - _scroll_arrow_down_margin_right;
_scroll_arrow_down_y = _menu_start_y + (_box_height * levels_to_display);

// If there are no levels available, set 'order by' option selected.
if array_length(levels) == 0 {
  current_level_index = -1;
}

if layer_exists("MakerLogo") {
  layer_set_visible("MakerLogo", false);
}

scr_inputcreate();

/// @desc This function loads all levels importing them from their files into levels folder.
import_levels_from_levels_folder = function() {
  levels = [];
  
  var _level_files = [],
      _file_pattern = $"{LEVEL_MAKER_LEVELS_FOLDER_PATH}/*.{LEVEL_MAKER_LEVEL_FILE_EXTENSION}",
      _level_filename = file_find_first(_file_pattern, fa_none);
  
  while _level_filename != "" {
    try {
    	var _level_file_path = $"{LEVEL_MAKER_LEVELS_FOLDER_NAME}/{_level_filename}",
          _level_json = level_maker_level_file_open(_level_file_path);
      
      array_push(levels, new MakerLevel(
        $"{LEVEL_MAKER_LEVELS_FOLDER_PATH}/{_level_filename}",
        _level_json.name,
        _level_json.author,
        _level_json.player_score,
        _level_json.perfect_score,
        _level_json.style,
        struct_exists(_level_json, "record_time") ? _level_json.record_time : -1
      ));
    } catch (_error) {
    	show_debug_message($"[!!!] Couldn't load level file {_level_filename}.\n {_error}");
    } finally {
      _level_filename = file_find_next();
    }
  }
  
  file_find_close();
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

__level_name_get_length_width = function() {
  var _txt = ""
  repeat(32) _txt += "A";
  return string_width(_txt);
};

__orderby_option_get_text = function() {
  switch(levels_orderby) {
    case LEVELS_ORDERBY.NAME_ASC: return LANG.maker_orderby_name_asc;
    case LEVELS_ORDERBY.NAME_DESC: return LANG.maker_orderby_name_desc;
    case LEVELS_ORDERBY.AUTHOR_ASC: return LANG.maker_orderby_author_asc;
    case LEVELS_ORDERBY.AUTHOR_DESC: return LANG.maker_orderby_author_desc;
    case LEVELS_ORDERBY.RANK_ASC: return LANG.maker_orderby_rank_asc;
    case LEVELS_ORDERBY.RANK_DESC: return LANG.maker_orderby_rank_desc;
  }
};

__levels_get_orderedby = function() {
  var _new_levels_arr = [];

  array_copy(_new_levels_arr, 0, levels, 0, array_length(levels));
  
  var _sort_name_asc = function(_arr) {
    array_sort(_arr, function(left, right) {
      var _left_name = string_lower(left.name),
          _right_name = string_lower(right.name);

      return _left_name < _right_name ? -1 : (_right_name < _left_name ? 1 : 0);
    });
  }

  switch(levels_orderby) {
    case LEVELS_ORDERBY.NAME_ASC: 
      _sort_name_asc(_new_levels_arr);
    break;

    case LEVELS_ORDERBY.NAME_DESC:
      array_sort(_new_levels_arr, function(left, right) {
        var _left_name = string_lower(left.name),
            _right_name = string_lower(right.name);
  
        return _left_name < _right_name ? 1 : (_right_name < _left_name ? -1 : 0);
      });
    break;

    case LEVELS_ORDERBY.AUTHOR_ASC:
      array_sort(_new_levels_arr, function(left, right) {
        var _left_author = string_lower(left.author),
            _right_author = string_lower(right.author);
  
        return _left_author < _right_author ? -1 : (_right_author < _left_author ? 1 : 0);
      });
    break;

    case LEVELS_ORDERBY.AUTHOR_DESC:
      array_sort(_new_levels_arr, function(left, right) {
        var _left_author = string_lower(left.author),
            _right_author = string_lower(right.author);
  
        return _left_author < _right_author ? 1 : (_right_author < _left_author ? -1 : 0);
      });
    break;

    case LEVELS_ORDERBY.RANK_ASC:
      array_sort(_new_levels_arr, function(left, right) {
        var _rank_order = ["S", "A", "B", "C", "D", "-"],
            _left_player_score = left.player_score,
            _left_perfect_score = left.perfect_score,
            _right_player_score = right.player_score,
            _right_perfect_score = right.perfect_score,
            _left_rank = __level_get_rank_letter(_left_player_score, _left_perfect_score),
            _right_rank = __level_get_rank_letter(_right_player_score, _right_perfect_score),
            _left_index = array_find_index_of_value(_rank_order, _left_rank),
            _right_index = array_find_index_of_value(_rank_order, _right_rank);

        return _left_index < _right_index ? 1 : (_left_index > _right_index ? -1 : 0);
      });
    break;

    case LEVELS_ORDERBY.RANK_DESC:
      array_sort(_new_levels_arr, function(left, right) {
        var _rank_order = ["S", "A", "B", "C", "D", "-"],
            _left_player_score = left.player_score,
            _left_perfect_score = left.perfect_score,
            _right_player_score = right.player_score,
            _right_perfect_score = right.perfect_score,
            _left_rank = __level_get_rank_letter(_left_player_score, _left_perfect_score),
            _right_rank = __level_get_rank_letter(_right_player_score, _right_perfect_score),
            _left_index = array_find_index_of_value(_rank_order, _left_rank),
            _right_index = array_find_index_of_value(_rank_order, _right_rank);

        return _left_index < _right_index ? -1 : (_left_index > _right_index ? 1 : 0);
      });
    break;
  }

  return _new_levels_arr;
};

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
    _letter = "S";
  }
  if _player_score < 0 {
    _letter = "-";
  }
  
  return _letter;
};

__handle_option_selection_on_input_nav_down = function() {
  var _levels = __levels_get_orderedby(),
      _levels_length = array_length(_levels),
      _level = _levels_length == 0 ? undefined : _levels[max(0, current_level_index)],
      _input_nav_up = key_up or (key_up_axis_pressed and not key_axis_pressed),
      _input_nav_down = key_down or (key_down_axis_pressed and not key_axis_pressed);

  if _input_nav_up and current_level_index > _option_index_minimum {
    __play_sound_on_navigate();
    
    current_level_index -= 1;
    if current_level_index < level_display_range_start {
      level_display_range_start = max(0, current_level_index);
      level_display_range_end = level_display_range_start + (levels_to_display - 1);
    }
    return;
  }
  
  if _input_nav_down and current_level_index < _levels_length - 1 {
    __play_sound_on_navigate();
    
    current_level_index += 1;
    if current_level_index > level_display_range_end {
      level_display_range_end = current_level_index;
      level_display_range_start = level_display_range_end - (levels_to_display - 1);
    }
  }
};

__handle_option_activation_on_input_press = function() {
  var _input_nav_select = key_start or key_jump_pressed;
  
  if not _input_nav_select {
    return;
  }
  
  __trigger_selected_option();
};

__handle_scroll_arrow_activation_on_mouse_click = function() {
  var _levels_length = array_length(__levels_get_orderedby()),
  
      _input_nav_down = mouse_wheel_down(),
      _input_nav_up = mouse_wheel_up();
  
  if _levels_length <= levels_to_display {
    return;
  }
  
  if not mouse_check_button_pressed(mb_left) {
    return;
  }
  
  if _mouse.is_into_rect_area(
    _scroll_arrow_up_x,
    _scroll_arrow_up_y,
    _scroll_arrow_up_x + _scroll_arrow_up_sprite_width,
    _scroll_arrow_up_y + _scroll_arrow_up_sprite_height
  ) {
    
    current_level_index -= 1;
    if current_level_index < 0 {
      current_level_index = 0;
    } else {
      __play_sound_on_navigate();  
    }
    if current_level_index < level_display_range_start {
      level_display_range_start = max(0, current_level_index);
      level_display_range_end = level_display_range_start + (levels_to_display - 1);
    }
    return;
  }
  
  if _mouse.is_into_rect_area(
    _scroll_arrow_down_x,
    _scroll_arrow_down_y,
    _scroll_arrow_down_x + _scroll_arrow_down_sprite_width,
    _scroll_arrow_down_y + _scroll_arrow_down_sprite_height
  ) {
    current_level_index = clamp(current_level_index, 0, _levels_length - 1);
    current_level_index += 1;
    if current_level_index >= _levels_length {
      current_level_index = _levels_length - 1;
    } else {
      __play_sound_on_navigate();
    }
      
    if current_level_index > level_display_range_end {
      level_display_range_end = current_level_index;
      level_display_range_start = level_display_range_end - (levels_to_display - 1);
    }
    return;
  }
}

__get_menu_option_mouse_hovered = function() {
  var _option_goback_left = _option_label_goback_x - string_width(__get_option_label_goback_text()),
      _option_goback_right = _option_label_goback_x,
      _option_goback_top = _option_label_goback_y,
      _option_goback_bottom = _option_label_goback_y + string_height(__get_option_label_goback_text());
  
  if _mouse.is_into_rect_area(
    _option_goback_left,
    _option_goback_top,
    _option_goback_right,
    _option_goback_bottom
  ) {
    return _option_index_goback;
  }
  
  var _option_orderby_yy = _option_label_orderby_y + string_height(__get_option_label_goback_text()),
      _option_orderby_left = _option_label_orderby_x - string_width(__get_option_label_orderby_text()),
      _option_orderby_right = _option_label_orderby_x,
      _option_orderby_top = _option_orderby_yy,
      _option_orderby_bottom = _option_orderby_yy + string_height(__get_option_label_orderby_text());
  
  if _mouse.is_into_rect_area(
    _option_orderby_left,
    _option_orderby_top,
    _option_orderby_right,
    _option_orderby_bottom
  ) {
    return _option_index_orderby;
  }
  
  _levels = __levels_get_orderedby();
  
  if array_length(_levels) == 0 {
    return undefined;
  }
  
  for (
    var i = level_display_range_start;
    i <= level_display_range_end and i - level_display_range_start < array_length(_levels);
    i++
  ) {
    var _levels_x = _menu_start_x + _box_margin_left,
        _levels_y = _menu_start_y + (_box_height + _box_margin_bottom) * (i - level_display_range_start),
        
        _option_box_left = _levels_x,
        _option_box_top = _levels_y,
        _option_box_right = _levels_x + _box_width,
        _option_box_bottom = _levels_y + _box_height;
    
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

__trigger_selected_option = function() {
var _levels = __levels_get_orderedby(),
    _levels_length = array_length(_levels),
    _level = _levels_length == 0 ? undefined : _levels[max(0, current_level_index)];
  
  __play_sound_on_select_option();
  
  var _shake_intensity = 0.4,
      _shake_duration = 2;

  shake_gamepad(_shake_intensity, _shake_duration);

  switch(current_level_index) {
    // Go back
    case _option_index_goback:
      menu_call_layer(menus_get_maker(), "main", "Instances");
      instance_destroy();
    exit;

    // Order by
    case _option_index_orderby:
      levels_orderby += 1;
      if levels_orderby >= LEVELS_ORDERBY.LENGTH {
        levels_orderby = 0;
      }
    break;

    // Levels
    default:
      var _level_description = instance_create_layer(-16, -16, "Instances", oLevelDescription);
      
      _level_description.level = _level;
    break;
  }
};

__handle_option_selection_on_mouse_hover = function() {
  if _mouse.is_hidden() {
    return;
  }
  
  var _option_index_hovered = __get_menu_option_mouse_hovered();
  
  if is_undefined(_option_index_hovered) {
    return;
  }
  
  if current_level_index != _option_index_hovered {
    current_level_index = _option_index_hovered;
    __play_sound_on_navigate();
  }
};

__update_mouse_cursor_type = function() {
  var _option_index_hovered = __get_menu_option_mouse_hovered();
  
  _mouse.cursor_type = MENU_CURSOR_TYPE.POINTER;
  
  // Options and levels
  if not is_undefined(_option_index_hovered) {
    _mouse.cursor_type = MENU_CURSOR_TYPE.FINGER;  
    return;
  }
  
  // Scroll arrows up/down
  var _levels_length = array_length(__levels_get_orderedby());
  
  if _levels_length <= levels_to_display {
    return;
  }
  
  if _mouse.is_into_rect_area(
    _scroll_arrow_down_x,
    _scroll_arrow_down_y,
    _scroll_arrow_down_x + _scroll_arrow_down_sprite_width,
    _scroll_arrow_down_y + _scroll_arrow_down_sprite_height
  ) {
    _mouse.cursor_type = MENU_CURSOR_TYPE.FINGER;
    return;
  }
  
  if _mouse.is_into_rect_area(
    _scroll_arrow_up_x,
    _scroll_arrow_up_y,
    _scroll_arrow_up_x + _scroll_arrow_up_sprite_width,
    _scroll_arrow_up_y + _scroll_arrow_up_sprite_height
  ) {
    _mouse.cursor_type = MENU_CURSOR_TYPE.FINGER;
    return;
  }
}

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

import_levels_from_levels_folder();
