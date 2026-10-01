//Initialise Nintendo Switch Controller settings

global.switch_controller_id = -1;

function input_switch_set_controller() {
	switch_controller_support_show();
	var _joycon_id = switch_controller_support_get_selected_id();
	global.switch_controller_id = _joycon_id;
	show_debug_message("[switch] controller set to joycon id: " + string(_joycon_id));
}

function input_switch_get(){
	
	var _cid = global.switch_controller_id;
	
	key_down_axis_pressed = (gamepad_axis_value(_cid,gp_axislv)>0.3);
	key_up_axis_pressed = (gamepad_axis_value(_cid,gp_axislv)<-0.3);
	
	key_right_pressed = gamepad_button_check_pressed(_cid,gp_padr) or (gamepad_axis_value(_cid,gp_axislh)>0.3);
	key_left_pressed = gamepad_button_check_pressed(_cid,gp_padl) or (gamepad_axis_value(_cid,gp_axislh)<-0.3);

	key_right = gamepad_button_check(_cid,gp_padr) or (gamepad_axis_value(_cid,gp_axislh)>0.3);
	key_left = gamepad_button_check(_cid,gp_padl) or (gamepad_axis_value(_cid,gp_axislh)<-0.3);
	key_down = gamepad_button_check_pressed(_cid,gp_padd);
	key_up = gamepad_button_check_pressed(_cid,gp_padu);
	key_jump_pressed =  gamepad_button_check_pressed(_cid,gp_face1) or gamepad_button_check_pressed(_cid,gp_face2) or gamepad_button_check_pressed(_cid,gp_face3);
	key_jump =  gamepad_button_check(_cid,gp_face1) or gamepad_button_check(_cid,gp_face2) or gamepad_button_check(_cid,gp_face3);
	key_start = gamepad_button_check_pressed(_cid,gp_start);
	key_reset = gamepad_button_check_pressed(_cid,gp_select);
	key_down_notpressed= gamepad_button_check(_cid,gp_padd) or (gamepad_axis_value(_cid,gp_axislv)>0.6);
}