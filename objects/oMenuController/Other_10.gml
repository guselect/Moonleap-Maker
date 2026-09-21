/// @desc Menu drawing

if is_disabled {
  exit;
}

if fill_background {
  draw_clear(_background_fill_color);
}

var _menu = menus[$ current_menu_name],
    _options_length = array_length(_menu),
    _current_option = _menu[_current_option_index],

    _text_halign = fa_center,
    _text_valign = fa_top,
    _text_font = oCamera.font,

    _text_wave_height = 2.25,
    _text_wave_time = 0.75,
    _text_wave_length = 1,
    _text_wave_char = "~",

    _text_blink_color = COLOR_NICE_WHITE,
    _text_blink_char = "#",

    _text_shake_char = "$",

    _option_base_alt_title_y1 = 64,
    _option_base_alt_title_y2 = 73,
    _option_color_default = use_alt_colors ? COLOR_NICE_BLUE : COLOR_NICE_MAGENTA,
    _option_color_selected = use_alt_colors ? COLOR_NICE_WHITE : COLOR_NICE_YELLOW,
    _option_letters_distance = 0,
    _option_line_distance = 12,
    _option_line_width = 320,
    _option_break_on_space = false,
    _option_alpha = 1,

    _description_base_x = GUI_W / 2,
    _description_base_y = 140,
    _description_text = _current_option.get_description(),
    _description_letters_distance = 0,
    _description_line_distance = 12,
    _description_line_width = 288,
    _description_break_on_space = false,
    _description_alpha = 1,
    _description_color = COLOR_NICE_YELLOW,

    _game_version_base_x = GUI_W - 21,
    _game_version_base_y = GUI_H - 18,
    _game_version_label = "v"+string_copy(GM_version,1,5),
    _game_version_label_color = COLOR_NICE_PURPLE,

    _title_base_x = GUI_W / 2,
    _title_base_y = _option_base_y - (_option_y_gap * 2),
    _title_text = __get_title(),
    _title_text_level_name = "",
    _title_text_author_name = "",
    _title_letters_distance = 0,
    _title_line_distance = 12,
    _title_line_width = 320,
    _title_break_on_space = false,
    _title_alpha = 1,
    _title_color = COLOR_NICE_DARK,
    _title_y_maker_pause = -18,
    _title_maker_play_spacing = 12,

    _title_text_wave_height = 2.25,
    _title_text_wave_time = 1,
    _title_text_wave_length = 100,
    _title_text_wave_char = "~";

draw_set_halign(_text_halign);
draw_set_valign(_text_valign);
draw_set_font(_text_font);

if show_title {
  if room_is([RoomMenu, RoomMenu2, RoomCredits, RoomCreditsAlves, Room100, rm_blank0]) {
  	_option_base_y = _option_base_alt_title_y1;
  } else {
  	_option_base_y = _option_base_alt_title_y2;
  }
  _title_text = $"~{_title_text}~";
  nox_set_wave(
    _title_text_wave_height,
    _title_text_wave_time,
    _title_text_wave_length,
    _title_text_wave_char
  );
  draw_set_color(_title_color);
  
  var _maker_controller = instance_find(oLevelMaker, 0);
  
  if room_is(RoomMaker0)
  and _maker_controller != noone
  and _maker_controller.mode == LEVEL_MAKER_EDITOR_MODE.PLAYING {
    _title_base_y += _title_y_maker_pause;
    _title_text_level_name = _maker_controller.level_name;
    _title_text_author_name = _maker_controller.level_author_name;
    draw_text_nox(
      _title_base_x,
      _title_base_y,
      _title_text_level_name,
      _title_letters_distance,
      _title_line_distance,
      _title_line_width,
      _title_break_on_space,
      _title_alpha
    );
    draw_text_nox(
      _title_base_x,
      _title_base_y + _title_maker_play_spacing,
      _title_text_author_name,
      _title_letters_distance,
      _title_line_distance,
      _title_line_width,
      _title_break_on_space,
      _title_alpha
    );
  } else {
    draw_text_nox(
      _title_base_x,
      _title_base_y,
      _title_text,
      _title_letters_distance,
      _title_line_distance,
      _title_line_width,
      _title_break_on_space,
      _title_alpha
    );
  }
}

nox_set_wave(
  _text_wave_height,
  _text_wave_time,
  _text_wave_length,
  _text_wave_char
);
nox_set_alternative_color(_text_blink_color, _text_blink_char);

if show_game_version {
  draw_set_color(_game_version_label_color);
  draw_text(_game_version_base_x, _game_version_base_y, _game_version_label);
}

for (var _i = 0; _i < _options_length; _i++) {
  var _menu_option = _menu[_i],
      _is_option_selected = _current_option_index == _i,
      _is_option_dangerous = _menu_option.is_dangerous,

      _option_x = _option_base_x,
      _option_y = _option_base_y + (_option_y_gap * _i),
      _option_text = _is_toggling ? _menu_option.get_label(_is_toggling) : _menu_option.get_label(),
      _option_color = _is_option_selected ? _option_color_selected : _option_color_default;
  
  draw_set_color(_option_color);
  
  if _is_option_selected {
    _option_text = _is_option_dangerous 
      ? $"{_text_shake_char}{_option_text}{_text_shake_char}"
      : $"{_text_wave_char}{_option_text}{_text_wave_char}";
	}
  draw_text_nox(
    _option_x,
    _option_y,
    _option_text,
    _option_letters_distance,
    _option_line_distance,
    _option_line_width,
    _option_break_on_space,
    _option_alpha
  );
}

if not is_undefined(_description_text) {
  if _current_option.is_dangerous {
    _description_text = $"{_text_blink_char}{_description_text}{_text_blink_char}";
  }
  draw_set_color(_description_color);
  draw_text_nox(
    _description_base_x,
    _description_base_y,
    _description_text,
    _description_letters_distance,
    _description_line_distance,
    _description_line_width,
    _description_break_on_space,
    _description_alpha
  );
}
