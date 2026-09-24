if is_disabled {
  exit;
}

oCamera.pause_delay = 10;

var _menus_length = struct_get_names(menus);

if instance_exists_any([oIntro, oTransition, oMessagePopup])
or array_length(_menus_length) == 0 {
  _mouse.visible = false;
  exit;
} else if not _mouse.visible {
  _mouse.visible = true;
}

scr_inputget();

__check_debugging_mode();

__handle_option_selection_on_input_nav_down();
__handle_option_selection_on_mouse_hover();

__handle_option_activation_on_input_select_press();
__handle_option_activation_on_mouse_click();

__handle_option_value_toggling();
