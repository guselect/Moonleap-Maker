/// @description Insert description here
// You can write your code in this editor
if oCamera.arcade=false
{
key_right= keyboard_check_pressed(ord("D")) or keyboard_check_pressed(vk_right)  or gamepad_button_check_pressed(0,gp_padr);
key_left= keyboard_check_pressed(ord("A")) or (keyboard_check_pressed(vk_left)  or gamepad_button_check_pressed(0,gp_padl));
key_down= keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down) or gamepad_button_check_pressed(0,gp_padd);
key_up= keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up) or gamepad_button_check_pressed(0,gp_padu);
key_start= keyboard_check_pressed(vk_enter) or gamepad_button_check_pressed(0,gp_start) or keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("X")) or keyboard_check_pressed(ord("Z")) or gamepad_button_check_pressed(0,gp_face1);
}
else
{
key_right=  keyboard_check_pressed(vk_right)  
key_left= keyboard_check_pressed(vk_left)
key_down=keyboard_check_pressed(vk_down) 
key_up=keyboard_check_pressed(vk_up) 
key_start= keyboard_check_pressed(ord("M")) or keyboard_check_pressed(ord("B")) or keyboard_check_pressed(ord("E")) or keyboard_check_pressed(ord("H"))
}



if instance_exists(oPlayer)
{if oPlayer.state.state_is("win") {ydraw=smooth_approach(ydraw,y,0.025)}}

if round(ydraw)=y and key_start=true
{
	ready=true
	if !instance_exists(oTransition)
	{
scr_restartgame()
	
	}
}

