var nice_dark = make_color_rgb(85, 85, 255);
var nice_yellow = make_color_rgb(170, 255, 255);
var nice_magenta = make_color_rgb(85, 170, 255);

nox_set_alternative_color(nice_magenta,"#");

draw_set_color(nice_black);
draw_clear(nice_black);

//Draw Menu
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(oCamera.font);

var _menu_ops = array_length(menu);
var _menu_y_gap = 14;

nox_set_wave(2.25, 1, 100, "~"); //full slow wave

draw_set_color(nice_dark);
draw_text_nox(320 / 2, _yy - (_menu_y_gap * 2), $"~{roomname}~", 0, 12, 320, false, 1);

nox_set_wave(2.25, 0.75, 1, "~");
for (var _i = 0; _i < _menu_ops; ++_i) { 
  var _menu_option = menu[_i];
	
  draw_set_color((option_index == _i) ? nice_yellow : nice_magenta);

	if option_index == _i {
    draw_text_nox(160, _yy + (_menu_y_gap * _i), $"~{_menu_option.text()}~", 0, 12, 320, false, 1);
  } else {
    draw_text_nox(160, _yy + (_menu_y_gap * _i), _menu_option.text(), 0, 12, 320, false, 1);
	}
}

if (menu == menus.assist) {
	draw_set_color(nice_magenta);
	if (option.name == "colorblind") {
		draw_text(160,140,LANG.text_full_colorblind);
	}
	if (option.name == "gamespeed") {
		draw_text(160,140,LANG.text_full_speed);
	}
}
