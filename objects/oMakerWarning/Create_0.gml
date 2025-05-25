nice_dark = make_color_rgb(85, 85, 255);
nice_black = make_color_rgb(0, 0, 72);
nice_white = make_color_rgb(170, 255, 255);

text_warning = "";

x_text = display_get_gui_width() / 2;
y_text_warning = display_get_gui_height() / 4;
y_text_options = display_get_gui_height() / 1.5;
y_text_option_gap = 12;

option_index = 0;
input_y = 0;

action_on_confirm = undefined;

scr_inputcreate();

play_ui_change_sound = function() {
  audio_play_sfx(sndUiChange, false, -18.3, 1);
}