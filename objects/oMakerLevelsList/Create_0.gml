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

// If there are no levels available, set 'order by' option selected.
if array_length(levels) == 0 {
  current_level_index = -1;
}

if layer_exists("MakerLogo") {
  layer_set_visible("MakerLogo", false);
}

scr_inputcreate();

play_sound_on_navigate = function() {
  var _sound = sndUiChange,
      _can_loop = false,
      _gain = -18.3,
      _pitch = 1;

  audio_play_sfx(_sound, _can_loop, _gain, _pitch);
};

play_sound_on_select_option = function() {
  var _ui_select_sound = sndUiChange,
      _priority = 1,
      _loop = false,
      _gain = 0.20 * (global.settings.enable_sfx),
      _offset = 0,
      _pitch = 1.4;

  audio_play_sound(_ui_select_sound, _priority, _loop, _gain, _offset, _pitch);
};

play_transition_sound = function() {
  menu_play_redirect_option_sound();
};

/// @desc Updates the level display range (start and end). Use this command when you change `levels_to_display` value.
update_level_display_range = function() {
  level_display_range_start = 0;
  level_display_range_end = levels_to_display - 1;
};

level_name_get_length_width = function() {
  var _txt = ""
  repeat(32) _txt += "A";
  return string_width(_txt);
};

orderby_option_get_text = function() {
  switch(levels_orderby) {
    case LEVELS_ORDERBY.NAME_ASC: return LANG.maker_orderby_name_asc;
    case LEVELS_ORDERBY.NAME_DESC: return LANG.maker_orderby_name_desc;
    case LEVELS_ORDERBY.AUTHOR_ASC: return LANG.maker_orderby_author_asc;
    case LEVELS_ORDERBY.AUTHOR_DESC: return LANG.maker_orderby_author_desc;
    case LEVELS_ORDERBY.RANK_ASC: return LANG.maker_orderby_rank_asc;
    case LEVELS_ORDERBY.RANK_DESC: return LANG.maker_orderby_rank_desc;
  }
};

levels_get_orderedby = function() {
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
            _left_rank = level_get_rank_letter(_left_player_score, _left_perfect_score),
            _right_rank = level_get_rank_letter(_right_player_score, _right_perfect_score),
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
            _left_rank = level_get_rank_letter(_left_player_score, _left_perfect_score),
            _right_rank = level_get_rank_letter(_right_player_score, _right_perfect_score),
            _left_index = array_find_index_of_value(_rank_order, _left_rank),
            _right_index = array_find_index_of_value(_rank_order, _right_rank);

        return _left_index < _right_index ? -1 : (_left_index > _right_index ? 1 : 0);
      });
    break;
  }

  return _new_levels_arr;
};

level_get_rank_letter = function(_player_score, _perfect_score) {
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

import_levels_from_levels_folder();
