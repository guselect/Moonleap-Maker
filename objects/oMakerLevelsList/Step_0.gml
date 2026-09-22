input_delay_frames = max(-1, input_delay_frames - 1);

if input_delay_frames == -1 {
  scr_inputget();
}

if instance_exists(oLevelDescription) {
  input_delay_frames = input_delay_frames_max;
  exit;
}

__update_mouse_cursor_type();

__handle_option_selection_on_input_nav_down();
__handle_option_selection_on_mouse_hover();
__handle_scroll_arrow_activation_on_mouse_click();

__handle_option_activation_on_input_press();
__handle_option_activation_on_mouse_click();