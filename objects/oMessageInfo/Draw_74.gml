var _text_letters_distance = 0,
    _text_line_distance = 12,
    _text_line_width = 296,
    _text_break_on_space = false,
    _text_alpha = 1,
    _text_halign = fa_center,
    _text_valign = fa_middle,
    
    _text_wave_height = 2.25,
    _text_wave_time = 0.75,
    _text_wave_length = 1,
    _text_wave_char = "~",
    
    _messages_length = array_length(messages),

    _message_x = GUI_W / 2,
    _message_y = GUI_H / 3,
    _message_text = messages[message_index],
    _message_line_distance = 16,
    
    _pagination_x = GUI_W / 2,
    _pagination_y = GUI_H - 36,
    _pagination_text = $"< {message_index + 1} / {_messages_length} >",
    _pagination_color = COLOR_NICE_BLUE,

    _close_option_text = $"~{__get_close_option_label()}~",
    _close_option_color = COLOR_NICE_WHITE;

nox_set_wave(
  _text_wave_height,
  _text_wave_time,
  _text_wave_length,
  _text_wave_char
);

draw_clear(bg_color);

draw_set_font(oCamera.font);
draw_set_halign(_text_halign);
draw_set_valign(_text_valign);
draw_set_color(message_color);

draw_text_nox(
  _message_x,
  _message_y,
  _message_text,
  _text_letters_distance,
  _message_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

draw_set_color(_pagination_color);
draw_text_nox(
  _pagination_x,
  _pagination_y,
  _pagination_text,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

draw_set_color(_close_option_color);
draw_text_nox(
  _close_option_x,
  _close_option_y,
  _close_option_text,
  _text_letters_distance,
  _text_line_distance,
  _text_line_width,
  _text_break_on_space,
  _text_alpha
);

draw_reset();
