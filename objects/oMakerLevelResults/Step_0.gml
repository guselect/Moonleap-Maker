scr_inputget();

if instance_exists_any([oTransition, oMakerTransition]) {
  exit;
}

__update_mouse_cursor_type();

__handle_option_selection_on_input_nav();
__handle_option_selection_on_mouse_hover();

__handle_option_activation_on_input_press();
__handle_option_activation_on_mouse_click();