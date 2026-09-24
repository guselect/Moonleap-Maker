/// @description Insert description here
// You can write your code in this editor

scr_inputget() //is what gives meaning to key_left key_right...

if (key_jump_pressed=true or key_start=true or mouse_check_button_pressed(mb_left)) { 
	if(!go){go=true; alarm[1] = game_get_speed(gamespeed_fps) *6;}
	else{
		alarm[0]=1;
	}
}

timer_atual++;
if(timer_atual >= timer_transicao){
	timer_atual = 0;
	if(cor_progresso_atual < cor_progresso_maximo){
		cor_progresso_atual++;
	}
	
	if(cor_total_atual < cor_total_maximo){
		cor_total_atual++;
	}
}

cor_progresso = cores[cor_progresso_atual];
cor_total = cores[cor_total_atual];