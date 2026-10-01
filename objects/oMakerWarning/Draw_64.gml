draw_set_color(COLOR_NICE_BLACK)
draw_clear(COLOR_NICE_BLACK);

draw_set_font(oCamera.font);

nox_set_wave(2.25, 1, 100, "~"); //full slow wave

var _message_warning_x = _option_base_x,
    _message_warning_y = _message_warning_base_y,
    _message_warning_text = $"~{text_warning}~",
    _message_warning_color = COLOR_NICE_DARK,
    _message_warning_halign = fa_center,
    _message_warning_valign = fa_top,
    _message_warning_letters_dist = 0,
    _message_warning_line_dist = 12,
    _message_warning_line_width = 240,
    _message_warning_break_on_space = false,
    _message_warning_alpha = 1;

draw_set_color(_message_warning_color);
draw_set_halign(_message_warning_halign);
draw_set_valign(_message_warning_valign);

draw_text_nox(
  _message_warning_x,
  _message_warning_y,
  _message_warning_text,
  _message_warning_letters_dist,
  _message_warning_line_dist,
  _message_warning_line_width,
  _message_warning_break_on_space,
  _message_warning_alpha
);

nox_set_wave(2.25, 0.75, 1, "~");

var _option_halign = fa_center,
    _option_valign = fa_middle;

draw_set_halign(_option_halign);
draw_set_valign(_option_valign);

for (var i = 0; i < MESSAGE_WARNING_OPTION.LENGTH; i++) {
  var _option_label = __get_option_label(i),
      _option_x = _option_base_x,
      _option_y = _option_base_y + (string_height(_option_label)) * i,
      _option_color = COLOR_NICE_DARK,
      _option_letters_dist = 0,
      _option_line_dist = 12,
      _option_line_width = GUI_W,
      _option_break_on_space = false,
      _option_alpha = 1;
  
  if current_option_index == i {
    _option_label = $"~{_option_label}~";
    _option_color = COLOR_NICE_WHITE;
  }
  
  draw_set_color(_option_color);
  
  draw_text_nox(
    _option_x,
    _option_y,
    _option_label,
    _option_letters_dist,
    _option_line_dist,
    _option_line_width,
    _option_break_on_space,
    _option_alpha
  );
}

draw_reset();