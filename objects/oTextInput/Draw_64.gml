draw_set_font(oCamera.font);

var _background_color = COLOR_NICE_BLACK,
    _text_input_color = COLOR_NICE_WHITE,
    
    _center_x = GUI_W / 2,
    _center_y = GUI_H / 2,
    
    _text_halign = fa_center,
    _text_valign = fa_middle,
    
    _text_letters_distance = 0,
    _text_line_distance = 12,
    _text_line_width = 320,
    _text_break_on_space = false,
    _text_alpha = 1,

    _title_base_x = _center_x,
    _title_base_y = _center_y - 32,
    _title_text = $"~{title}~",
    _title_color = COLOR_NICE_DARK,
    
    _hint_color = COLOR_NICE_DARK,

    _title_text_wave_height = 2.25,
    _title_text_wave_time = 1,
    _title_text_wave_length = 100,
    _title_text_wave_char = "~";

draw_clear(_background_color);
draw_set_halign(_text_halign);
draw_set_valign(_text_valign);

nox_set_wave(
  _title_text_wave_height,
  _title_text_wave_time,
  _title_text_wave_length,
  _title_text_wave_char
);
draw_set_color(_title_color);
draw_text_nox(
  _title_base_x,
  _title_base_y,
  _title_text,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

var _display_user_input = user_input;
if string_length(user_input) < input_string_max {
  _display_user_input += "_";
}

draw_set_color(_text_input_color);
draw_text_nox(
  _center_x,
  _center_y,
  _display_user_input,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

var _display_user_input_height = string_height(_display_user_input),
    _hint_text = $"{LANG.maker_chars}{string_length(user_input)} / {input_string_max}",
    _hint_text_y = _center_y + _display_user_input_height + 4;

if input_string_min > 0 {
  _hint_text += $" - {LANG.maker_minimum}{input_string_min}";
}

draw_set_color(_hint_color);
draw_text_nox(
  _center_x,
  _hint_text_y, 
  _hint_text,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

var _description_x = _center_x,
    _description_y = _hint_text_y + 32,
    _description_text = LANG.text_input_description,
    _description_color = COLOR_NICE_BLUE;

draw_set_color(_description_color);
draw_text_nox(
  _description_x,
  _description_y, 
  _description_text,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width - 48,
  _text_break_on_space,
  _text_alpha
);

draw_set_color(-1);
draw_set_halign(-1);
draw_set_valign(-1);
