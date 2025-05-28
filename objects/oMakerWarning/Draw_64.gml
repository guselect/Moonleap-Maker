draw_set_halign(fa_center)
draw_set_valign(fa_middle)

draw_set_color(nice_black)
draw_clear(nice_black);

nox_set_wave(2.25, 1, 100, "~"); //full slow wave

draw_set_color(nice_dark);

draw_set_font(oCamera.font);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

var _font_size = font_get_size(draw_get_font());

draw_text_nox(x_text, y_text_warning, $"~{text_warning}~", 0, 12, 240, false, 1);

nox_set_wave(2.25, 0.75, 1, "~");

var _option_confirm_text = LANG.maker_warning_confirm;
var _option_cancel_text = LANG.maker_warning_cancel;

if option_index == 0 {
  _option_confirm_text = $"~{_option_confirm_text}~";
} else {
  _option_cancel_text = $"~{_option_cancel_text}~";
}

var _color_option_confirm = option_index == 0 ? nice_white : nice_dark;
var _color_option_cancel = option_index == 1 ? nice_white : nice_dark;

draw_set_color(_color_option_confirm);
draw_text_nox(x_text, y_text_options, _option_confirm_text, 0, 12, 320, false, 1);

draw_set_color(_color_option_cancel);
draw_text_nox(x_text, y_text_options + _font_size + y_text_option_gap, _option_cancel_text, 0, 12, 320, false, 1);
