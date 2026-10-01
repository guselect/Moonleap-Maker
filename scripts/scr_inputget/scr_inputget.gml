// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_inputget()
{
	key_axis_pressed = key_right_axis_pressed or key_left_axis_pressed or key_down_axis_pressed or key_up_axis_pressed;

	//get inputs
	if (not oCamera.arcade) {
		//If we are on switch, call the switch input script instead
		if (os_type == os_switch) {
			input_switch_get();
			exit;
		}
    
    var _gpad_device_index = 0,
        _gpad_axis_deadzone = 0.3;
		
		key_down_axis_pressed = gamepad_axis_value(_gpad_device_index, gp_axislv) > _gpad_axis_deadzone;
		key_up_axis_pressed = gamepad_axis_value(_gpad_device_index, gp_axislv) < -_gpad_axis_deadzone;
		key_right_axis_pressed = gamepad_axis_value(_gpad_device_index, gp_axislh) > _gpad_axis_deadzone;
		key_left_axis_pressed = gamepad_axis_value(_gpad_device_index, gp_axislh) < -_gpad_axis_deadzone;
    
    key_right = keyboard_check(ord("D"))
      or keyboard_check(vk_right) 
      or gamepad_button_check(_gpad_device_index, gp_padr)
      or gamepad_axis_value(_gpad_device_index, gp_axislh) > _gpad_axis_deadzone
      or obDirection.key_right;
		key_right_pressed = keyboard_check_pressed(ord("D"))
      or keyboard_check_pressed(vk_right) 
      or gamepad_button_check_pressed(_gpad_device_index, gp_padr)
      or obDirection.key_right;
    
    key_left = keyboard_check(ord("A"))
      or keyboard_check(vk_left)
      or gamepad_button_check(_gpad_device_index, gp_padl)
      or gamepad_axis_value(_gpad_device_index, gp_axislh) < -_gpad_axis_deadzone
      or obDirection.key_left;
		key_left_pressed = keyboard_check_pressed(ord("A"))
      or keyboard_check_pressed(vk_left)
      or gamepad_button_check_pressed(_gpad_device_index, gp_padl)
      or obDirection.key_left;
    
    key_down = keyboard_check_pressed(ord("S"))
      or keyboard_check_pressed(vk_down) 
      or gamepad_button_check_pressed(_gpad_device_index, gp_padd)
      or obDirection.key_down;
    key_down_notpressed = keyboard_check(ord("S"))
      or keyboard_check(vk_down)
      or gamepad_button_check(_gpad_device_index, gp_padd)
      or obDirection.key_down;
    
		key_up = keyboard_check_pressed(ord("W"))
      or keyboard_check_pressed(vk_up)
      or gamepad_button_check_pressed(_gpad_device_index, gp_padu)
      or obDirection.key_up;
    
    key_jump = 
      keyboard_check(vk_space)
      or keyboard_check(ord("X"))
      or keyboard_check(ord("Z"))
      or gamepad_button_check(_gpad_device_index, gp_face1)
      or gamepad_button_check(_gpad_device_index, gp_face2)
      or gamepad_button_check(_gpad_device_index, gp_face3) 
      or obJump.key_jump;
		key_jump_pressed = keyboard_check_pressed(vk_space)
      or keyboard_check_pressed(ord("X"))
      or keyboard_check_pressed(ord("Z"))
      or gamepad_button_check_pressed(_gpad_device_index, gp_face1)
      or gamepad_button_check_pressed(_gpad_device_index, gp_face2)
      or gamepad_button_check_pressed(_gpad_device_index, gp_face3)
      or obJump.key_jump;
		key_start = keyboard_check_pressed(vk_enter)
      or gamepad_button_check_pressed(_gpad_device_index, gp_start)
      or oBpause.key_start;
		key_reset = keyboard_check_pressed(ord("R"))
      or gamepad_button_check_pressed(_gpad_device_index, gp_select);
    
    // Level Maker
    key_cursor_move_down = keyboard_check(ord("S"))
      or gamepad_axis_value(_gpad_device_index, gp_axislv) > _gpad_axis_deadzone
      or gamepad_axis_value(_gpad_device_index, gp_axisrv) > _gpad_axis_deadzone;
    key_cursor_move_up = keyboard_check(ord("W"))
      or gamepad_axis_value(_gpad_device_index, gp_axislv) < -_gpad_axis_deadzone
      or gamepad_axis_value(_gpad_device_index, gp_axisrv) < -_gpad_axis_deadzone;
    key_cursor_move_left = keyboard_check(ord("A"))
      or gamepad_axis_value(_gpad_device_index, gp_axislh) < -_gpad_axis_deadzone
      or gamepad_axis_value(_gpad_device_index, gp_axisrh) < -_gpad_axis_deadzone;
    key_cursor_move_right = keyboard_check(ord("D"))
      or gamepad_axis_value(_gpad_device_index, gp_axislh) > _gpad_axis_deadzone
      or gamepad_axis_value(_gpad_device_index, gp_axisrh) > _gpad_axis_deadzone;
    
    key_cursor_left_click_pressing = mouse_check_button(mb_left)
      or keyboard_check(ord("Q"))
      or gamepad_button_check(_gpad_device_index, gp_shoulderl);
    key_cursor_left_click_pressed = mouse_check_button_pressed(mb_left)
      or keyboard_check_pressed(ord("Q"))
      or gamepad_button_check_pressed(_gpad_device_index, gp_shoulderl);
    key_cursor_left_click_released = mouse_check_button_released(mb_left)
      or keyboard_check_released(ord("Q"))
      or gamepad_button_check_released(_gpad_device_index, gp_shoulderl);
    
    key_cursor_right_click_pressing = mouse_check_button(mb_right)
      or keyboard_check(ord("E"))
      or gamepad_button_check(_gpad_device_index, gp_shoulderr);
    key_cursor_right_click_pressed = mouse_check_button_pressed(mb_right)
      or keyboard_check_pressed(ord("E"))
      or gamepad_button_check_pressed(_gpad_device_index, gp_shoulderr);
    key_cursor_right_click_released = mouse_check_button_released(mb_right)
      or keyboard_check_released(ord("E"))
      or gamepad_button_check_released(_gpad_device_index, gp_shoulderr);
    
    key_maker_list_page_up = keyboard_check_pressed(vk_up)
      or gamepad_button_check_pressed(_gpad_device_index, gp_padu)
      or mouse_wheel_up();
    key_maker_list_page_down = keyboard_check_pressed(vk_down)
      or gamepad_button_check_pressed(_gpad_device_index, gp_padd)
      or mouse_wheel_down();
    key_maker_item_select_left = keyboard_check_pressed(vk_left)
      or gamepad_button_check_pressed(_gpad_device_index, gp_padl);
    key_maker_item_select_right = keyboard_check_pressed(vk_right)
      or gamepad_button_check_pressed(_gpad_device_index, gp_padr);
    
    key_maker_item_rotate = keyboard_check_pressed(ord("Z"))
      or gamepad_button_check_pressed(_gpad_device_index, gp_face4);
    key_maker_item_mirror = keyboard_check_pressed(ord("X"))
      or gamepad_button_check_pressed(_gpad_device_index, gp_face3);
    
    key_maker_toggle_test = keyboard_check_pressed(vk_f5)
      or gamepad_button_check_pressed(_gpad_device_index, gp_start);
    key_maker_creator_menu = keyboard_check_pressed(vk_return)
      or keyboard_check_pressed(vk_escape)
      or gamepad_button_check_pressed(_gpad_device_index, gp_select);
	}
	else
	{
		key_right =  keyboard_check(vk_right)  
		key_left = keyboard_check(vk_left)
		key_right_pressed =  keyboard_check_pressed(vk_right)  
		key_left_pressed = keyboard_check_pressed(vk_left)
		key_down = keyboard_check(vk_down)
		key_up = keyboard_check(vk_up) 
		key_jump_pressed =  keyboard_check_pressed(ord("B")) or keyboard_check_pressed(ord("E")) or keyboard_check_pressed(ord("H"))
		key_jump = keyboard_check(ord("B")) or keyboard_check(ord("E"))  or keyboard_check(ord("H"))
		key_start = keyboard_check_pressed(ord("M")) or oBpause.key_start;
		key_reset = keyboard_check_pressed(ord("R"))
	}
}