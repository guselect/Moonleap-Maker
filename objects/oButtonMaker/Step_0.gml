if oLevelMaker.mode == LEVEL_MAKER_EDITOR_MODE.PLAYING {
  instance_destroy();
  exit;
}

scr_inputget();

var _is_left_pressing = key_cursor_left_click_pressing,
    _has_left_pressed = key_cursor_left_click_pressed,
    _mouse_x = global.level_maker_mouse_x,
    _mouse_y = global.level_maker_mouse_y,
    _obj = self,
    _is_precise = false,
    _not_me = false,
    _is_mouse_hover = collision_point(_mouse_x, _mouse_y, _obj, _is_precise, _not_me);

// Button shaking effect
drawx = random_range(-holding_button_frames, holding_button_frames);
drawy = random_range(-holding_button_frames, holding_button_frames);

if has_cleared_level {
	drawx = 0;
	drawy = 0;
}

drawtarget = 0;

// Lerp play button position to be visible in play state
if image_index == LEVEL_MAKER_BUTTON_TYPE.TEST_LEVEL {
    //editor is opened
	if level_maker_is_editing() {
		x = lerp(x, start_pos_x, 0.2);
		y = lerp(y, start_pos_y, 0.2);
		
		image_xscale = lerp(image_xscale, 1, 0.2);
		image_yscale = image_xscale;
	} else {
		x = lerp(x, (32-small_size) / 2, 0.2);
		y = lerp(y, room_height - 16 - small_size / 2, 0.2);

		image_xscale = lerp(image_xscale, small_size / 32, 0.2);
		image_yscale = image_xscale;
	}
} else if not level_maker_is_editing()
  or instance_exists(oPauseUI) {
  exit;
}

__update_hover_text();

if instance_exists(oMessagePopup) {
  exit;
}

if _is_mouse_hover and _is_left_pressing { 
  drawplus = 2;
} else {
	holding_button_frames = 0; 
	has_cleared_level = false;
	_has_left_pressed = false;
}

// ===================================
// BUTTON ACTIONS BY USING SHORTCUTS
// ===================================

if image_index == LEVEL_MAKER_BUTTON_TYPE.PAGE_UP
and key_maker_list_page_up {
	__action_items_page_up();
}

if image_index == LEVEL_MAKER_BUTTON_TYPE.PAGE_DOWN
and key_maker_list_page_down {
	__action_items_page_down();
}

if image_index == LEVEL_MAKER_BUTTON_TYPE.SAVE_LEVEL
and keyboard_check(vk_control)
and keyboard_check_pressed(ord("S")) {
  __action_save_level();
}

if image_index == LEVEL_MAKER_BUTTON_TYPE.MENU
and key_maker_creator_menu {
  __action_menu();
}

if image_index == LEVEL_MAKER_BUTTON_TYPE.LOAD_LEVEL
and keyboard_check(vk_control)
and keyboard_check_pressed(ord("O")) {
  __action_load_level();
}

if image_index == LEVEL_MAKER_BUTTON_TYPE.TEST_LEVEL
and key_maker_toggle_test {
  __action_test_level();
}

// ===================================
// BUTTON ACTIONS BY PRESSING IT
// ===================================

switch(image_index) {
  case LEVEL_MAKER_BUTTON_TYPE.CLEAR_LEVEL:
    __action_clear_level();
  break;
}

// Buttons on pressing once.
if _has_left_pressed and _is_mouse_hover {
  switch(image_index) {
    case LEVEL_MAKER_BUTTON_TYPE.PAGE_UP:
      __action_items_page_up();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.PAGE_DOWN:
      __action_items_page_down();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.MENU:
      __action_menu();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.SAVE_LEVEL:
      __action_save_level();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.LOAD_LEVEL:
      __action_load_level();
    break;
  
    case LEVEL_MAKER_BUTTON_TYPE.TEST_LEVEL:
      __action_test_level();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.HELP:
      __action_help();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.CHANGE_STYLE:
      __action_change_style();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.ERASER:
      __action_eraser();
    break;

    case LEVEL_MAKER_BUTTON_TYPE.CHANGE_LAYER:
      __action_change_layer();
    break;
  }
}