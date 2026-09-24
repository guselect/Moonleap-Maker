/// @description Insert description here
// You can write your code in this editor
scr_inputget()


if(key_jump or mouse_check_button(mb_left)){
	multiplicador_timer = .1;
}else{
	multiplicador_timer = 1;
}

timer_atual++;
if(!fim_fade){
	if(!reverso){
		if(timer_atual >= timer_transicao * multiplicador_timer){
			if(cor_nome_atual < cor_nome){
				cor_nome_atual++;
			}
	
			if(cor_titulo_atual < cor_titulo){
				cor_titulo_atual++;
			}
			timer_atual = 0;
		}
	
		if cor_nome == cor_nome_atual and cor_titulo == cor_titulo_atual {
			reverso = true;
			timer_transicao = timer_transicao_lento;
		}
	}else{
		if(timer_atual >= timer_transicao * multiplicador_timer){
			timer_transicao = timer_transicao_rapid;
			if(cor_nome_atual > 0){
				cor_nome_atual--;
			}
	
			if(cor_titulo_atual > 0 and cor_nome_atual+1 == cor_titulo_atual){
				cor_titulo_atual--;
			}
			timer_atual = 0;
		}
		if 0 == cor_nome_atual and 0 == cor_titulo_atual {
			reverso = false;
			if(nome_atual < array_length(LANG.nome)-1){
				nome_atual++;
				titulo_atual++;
			}else{
				//if !instance_exists(oTransition)
				//{
				//audio_play_sfx(sndStarGame,false,-6.2,0)
				//var trans=instance_create_layer(0,0,layer,oTransition)
				//trans.target_room=RoomMenu;
				//}
				fim_fade = true;
			}
		}
	}
}else{
	y_move -= y_move_speed / multiplicador_timer;
}

if terminou=true and (key_start or key_jump_pressed or mouse_check_button_pressed(mb_left))
{
	if !instance_exists(oTransition)
	{
		audio_play_sfx(sndStarGame,false,-6.2,0)
		var trans=instance_create_layer(0,0,layer,oTransition)
		if(!instance_exists(oVaiProgresso)){
			trans.target_room=RoomMenu;
		}else{
			trans.target_room=RoomProgress;
			with(oVaiProgresso){
				instance_destroy();
			}
		}
	}
}

