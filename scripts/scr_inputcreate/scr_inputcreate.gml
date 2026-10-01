function scr_inputcreate() {
	gamepad_set_axis_deadzone(0, 0.3);
  
  // Player movement and UI navigation
	key_right = false;
	key_right_pressed = false;
  key_left = false;
	key_left_pressed = false;
	key_down = false;
	key_down_pressed = false;
  key_down_notpressed = 0;
	key_up = false;
	key_jump = false;
  key_jump_pressed = false;
	key_start = false;
  key_reset = false;
  
  // Gamepad Axis
  key_axis_pressed = false;
  key_right_axis_pressed = 0;
  key_left_axis_pressed = 0;
  key_down_axis_pressed = 0;
	key_up_axis_pressed = 0;
  
  // Level Maker
  key_cursor_move_down = false;
  key_cursor_move_up = false;
  key_cursor_move_left = false;
  key_cursor_move_right = false;
  key_cursor_left_click_pressing = false;
  key_cursor_left_click_pressed = false;
  key_cursor_left_click_released = false;
  key_cursor_right_click_pressing = false;
  key_cursor_right_click_pressed = false;
  key_cursor_right_click_released = false;
  
  key_maker_toggle_test = false;
  key_maker_creator_menu = false;
  
  key_maker_list_page_up = false;
  key_maker_list_page_down = false;
  
  key_maker_item_select_left = false;
  key_maker_item_select_right = false;
  key_maker_item_rotate = false;
  key_maker_item_mirror = false;
}