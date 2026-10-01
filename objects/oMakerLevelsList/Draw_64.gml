var _levels = __levels_get_orderedby(),
    _levels_length = array_length(_levels),

    _text_halign = fa_left,
    _text_valign = fa_top,
    _text_font = oCamera.font,
    _text_color_default = COLOR_NICE_MAGENTA,
    _text_color_selected = COLOR_NICE_YELLOW,
    _text_letters_distance = 0,
    _text_line_distance = 12,
    _text_line_width = _box_width - _text_padding_right,
    _text_break_on_space = false,
    _text_alpha = 1,

    _text_wave_height = 2.25,
    _text_wave_time = 0.75,
    _text_wave_length = 1,
    _text_wave_char = "~",
    
    _text_blink_color = COLOR_NICE_WHITE,
    _text_blink_char = "#",
    
    _label_rank_text = LANG.maker_rank_title,
    _label_rank_margin_right = 8,

    _label_goback_x = _option_label_goback_x,
    _label_goback_y = _option_label_goback_y,
    _label_goback_is_selected = current_level_index == -2,
    _label_goback_text = _label_goback_is_selected ?
        $"~{__get_option_label_goback_text()}~" 
        : $"{__get_option_label_goback_text()}",
    _label_goback_color = _label_goback_is_selected ? _text_color_selected : _text_color_default,
    _label_goback_halign = fa_right,
    _label_goback_valign = fa_top,
    _label_goback_size = string_height(_label_goback_text),

    _label_orderby_x = _option_label_orderby_x,
    _label_orderby_y = _option_label_orderby_y + _label_goback_size,
    _label_orderby_is_selected = current_level_index == -1,
    _label_orderby_title = LANG.maker_orderby,
    _label_orderby_option = __orderby_option_get_text(),
    _label_orderby_text = _label_orderby_is_selected ?
        $"~{_label_orderby_title}{_label_orderby_option}~"
        : $"{_label_orderby_title}{_label_orderby_option}",
    _label_orderby_color = _label_orderby_is_selected ? _text_color_selected : _text_color_default,
    _label_orderby_halign = fa_right,
    _label_orderby_valign = fa_top,
    _label_orderby_size = string_height(_label_orderby_text),

    _label_levelnumber_x = _text_margin_left,
    _label_levelnumber_y = _text_margin_top + _label_goback_size,
    _label_levelnumber_text = $"{LANG.maker_levels}{max(1, current_level_index + 1)} / {_levels_length}",
    _label_levelnumber_halign = fa_left,
    _label_levelnumber_valign = fa_top,

    _label_nolevels_x = GUI_W / 2,
    _label_nolevels_y = GUI_H / 2,
    _label_nolevels_text = $"{LANG.maker_nolevels}",
    _label_nolevels_halign = fa_center,
    _label_nolevels_valign = fa_middle,

    _scroll_bar_sprite = sLevelScrollBar,
    _scroll_bar_sprite_frame = current_level_index >= 0,    
    _scroll_bar_sprite_width = sprite_get_width(_scroll_bar_sprite),
    _scroll_bar_sprite_height = sprite_get_height(_scroll_bar_sprite),
    _scroll_bar_margin_right = 3,
    _scroll_bar_x = GUI_W - _scroll_arrow_down_sprite_width - _scroll_arrow_down_margin_right,
    _scroll_bar_y_from = _scroll_arrow_up_y + _scroll_arrow_up_sprite_height + 2,
    _scroll_bar_y_to = _scroll_arrow_down_y - _scroll_arrow_down_sprite_height - 4,
    _scroll_bar_y_percent = max(0, current_level_index) / (_levels_length - 1),
    _scroll_bar_y_distance = _scroll_bar_y_to - _scroll_bar_y_from,
    _scroll_bar_y = _scroll_bar_y_from + (_scroll_bar_y_percent * _scroll_bar_y_distance);

nox_set_alternative_color(_text_blink_color, _text_blink_char);

draw_set_valign(_text_valign);
draw_set_font(_text_font);
nox_set_wave(
  _text_wave_height,
  _text_wave_time,
  _text_wave_length,
  _text_wave_char
);

draw_set_color(_label_goback_color); 
draw_set_halign(_label_goback_halign);
draw_set_valign(_label_goback_valign);
draw_text_nox(
  _label_goback_x,
  _label_goback_y,
  _label_goback_text,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

if _levels_length > 0 {
  draw_set_color(_text_color_default);
  draw_set_halign(_label_levelnumber_halign);
  draw_set_valign(_label_levelnumber_valign);
  draw_text_nox(
    _label_levelnumber_x,
    _label_levelnumber_y,
    _label_levelnumber_text,
    _text_letters_distance,
    _text_line_distance,
    _text_line_width,
    _text_break_on_space,
    _text_alpha
  );
} else {
  draw_set_color(_text_color_default);
  draw_set_halign(_label_nolevels_halign);
  draw_set_valign(_label_nolevels_valign);
  draw_text_nox(
    _label_nolevels_x,
    _label_nolevels_y,
    _label_nolevels_text,
    _text_letters_distance,
    _text_line_distance,
    _text_line_width,
    _text_break_on_space,
    _text_alpha
  );
}


draw_set_color(_label_orderby_color);
draw_set_halign(_label_orderby_halign);
draw_set_valign(_label_orderby_valign);
draw_text_nox(
  _label_orderby_x,
  _label_orderby_y,
  _label_orderby_text,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

// Level boxes
for (var _i = level_display_range_start; _i <= level_display_range_end and _i < _levels_length; _i++) {
  var _level = _levels[_i],
      _level_name = _level.name,
      _level_author = _level.author,
      _level_player_score = _level.player_score,
      _level_perfect_score = _level.perfect_score,

      _is_selected = _i == current_level_index,
      _levels_x = _menu_start_x + _box_margin_left,
      _levels_y = _menu_start_y + (_box_height + _box_margin_bottom) * (_i - level_display_range_start),

      _text_color = _is_selected ? _text_color_selected : _text_color_default,

      _level_name_x = _levels_x + _text_padding_left,
      _level_name_y = _levels_y + _text_padding_top,
      _level_name_label = _is_selected ? $"~{_level_name}~" : _level_name,
      _level_name_height = string_height(_level_name_label),

      _level_author_x = _levels_x + _text_padding_left,
      _level_author_y = _levels_y + _level_name_height + _text_padding_top,
      _level_author_label = _is_selected ? $"~{_level_author}~" : _level_author,

      _rank_title_text = _is_selected ? $"~{_label_rank_text}~" : $"{_label_rank_text}",
      _rank_title_x = _level_name_x + __level_name_get_length_width(),
      _rank_title_y = _level_name_y,

      _rank_label_letter = __level_get_rank_letter(_level_player_score, _level_perfect_score),
      _rank_label_text = _is_selected ? $"~{_rank_label_letter}~" : _rank_label_letter,
      _rank_label_x = GUI_W - _box_margin_right - _text_margin_right,
      _rank_label_y = _level_name_y;

  draw_sprite_stretched(_box_sprite, _is_selected, _levels_x, _levels_y, _box_width, _box_height);

  draw_set_color(_text_color);
  draw_set_halign(_text_halign);

  // Level name
  draw_text_nox(
    _level_name_x,
    _level_name_y,
    _level_name_label,
    _text_letters_distance,
    _text_line_distance,
    _text_line_width,
    _text_break_on_space,
    _text_alpha
  );
  
  // Author name
  draw_text_nox(
    _level_author_x,
    _level_author_y,
    _level_author_label,
    _text_letters_distance,
    _text_line_distance,
    _text_line_width,
    _text_break_on_space,
    _text_alpha
  );
  
  // Rank letter
  draw_text_nox(
    _rank_label_x,
    _rank_label_y,
    _rank_label_text,
    _text_letters_distance,
    _text_line_distance,
    _text_line_width,
    _text_break_on_space,
    _text_alpha
  );
}

// Scroll bar
if _levels_length > 3 {
  draw_sprite(_scroll_arrow_up_sprite, _scroll_bar_sprite_frame, _scroll_arrow_up_x, _scroll_arrow_up_y);
  draw_sprite(_scroll_arrow_down_sprite, _scroll_bar_sprite_frame, _scroll_arrow_down_x, _scroll_arrow_down_y);
  draw_sprite(_scroll_bar_sprite, _scroll_bar_sprite_frame, _scroll_bar_x, _scroll_bar_y);
}
