var _text_wave_height = 2.25,
    _text_wave_time = 0.75,
    _text_wave_length = 1,
    _text_wave_char = "~",
    
    _text_blink_color = COLOR_NICE_WHITE,
    _text_blink_char = "#",
    
    _title_text_halign = fa_center,
    _title_text_valign = fa_middle,
    _title_text_color = COLOR_NICE_MAGENTA,

    _title_level_name_x = GUI_W / 2,
    _title_level_name_y = _box_top + _text_height,
    _title_level_name_text = $"{level.name}",

    _title_level_author_x = GUI_W / 2,
    _title_level_author_y = _box_top + (_text_height * 2),
    _title_level_author_text = $"{level.author}",
    
    _level_player_score = level.player_score,
    _level_perfect_score = level.perfect_score,
    _level_rank_letter = __level_get_rank_letter(_level_player_score, _level_perfect_score),
    _level_record_time = level.record_time <= -1 ? "-" : time_get_format_mm_ss_ms(level.record_time),
    
    _description_rank_x = GUI_W / 2,
    _description_rank_y = _box_top + (_text_height * 4) - 12,
    _description_rank_text = $"{LANG.maker_rank_title}{_level_rank_letter}",

    _description_record_time_x = GUI_W / 2,
    _description_record_time_y = _box_top + (_text_height * 5) - 12,
    _description_record_time_text = $"{LANG.maker_level_record_time}{_level_record_time}",
    
    _text_color_default = COLOR_NICE_MAGENTA,
    _text_color_selected = COLOR_NICE_YELLOW,
    _text_letters_distance = 0,
    _text_line_distance = 12,
    _text_line_width = GUI_W,
    _text_break_on_space = false,
    _text_alpha = 1,

    _option_halign = fa_center,
    _option_valign = fa_middle;

draw_sprite_stretched(
  _box_sprite,
  _box_frame,
  _box_left,
  _box_top,
  _box_width,
  _box_height
);

nox_set_alternative_color(_text_blink_color, _text_blink_char);

nox_set_wave(
  _text_wave_height,
  _text_wave_time,
  _text_wave_length,
  _text_wave_char
);

draw_set_halign(_title_text_halign);
draw_set_valign(_title_text_valign);
draw_set_color(_title_text_color);

draw_text_nox(
  _title_level_name_x,
  _title_level_name_y,
  _title_level_name_text,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

draw_text_nox(
  _title_level_author_x,
  _title_level_author_y,
  _title_level_author_text,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

draw_text_nox(
  _description_rank_x,
  _description_rank_y,
  _description_rank_text,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

draw_text_nox(
  _description_record_time_x,
  _description_record_time_y,
  _description_record_time_text,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

draw_set_halign(_option_halign);
draw_set_valign(_option_valign);

for (var i = 0; i < LEVEL_MAKER_DESCRIPTION_OPTION.LENGTH; i++) {
  var _draw_option_x = _option_x,
      _draw_option_y = _option_y + _text_height * i,
      _opt_color = _text_color_default,
      _opt_label = __get_option_label(i);
  
  if i == current_option {
    _opt_color = _text_color_selected;
    _opt_label = $"~{_opt_label}~";
  }
  
  draw_set_color(_opt_color);
  
  draw_text_nox(
    _draw_option_x,
    _draw_option_y,
    _opt_label,
    _text_letters_distance,
    _text_line_distance,
    _text_line_width,
    _text_break_on_space,
    _text_alpha
  );
}

draw_reset();
