/// @description Insert description here

scr_inputget();
// You can write your code in this editor
	drawx=random_range(-(holding),(holding))
	drawy=random_range(-(holding),(holding))
	drawtarget=0

//lerp play button position to be visible in play state
if image_index=6 { //play button
	
	if instance_exists(oPause) //editor is opened 
	{
		
		x = lerp(x,start_pos_x,.2);
		y = lerp(y,start_pos_y,.2);
		
		image_xscale = lerp(image_xscale,1,.2);
		image_yscale = image_xscale;
	} else {
	
		x = lerp(x,(32-small_size)/2,.2);
		y = lerp(y,room_height-16-small_size/2,.2);

		image_xscale = lerp(image_xscale,small_size/32,.2);
		image_yscale = image_xscale;
	}

} else {
	
	if !instance_exists(oPause) {exit}

}


var is_mouse_left_pressing = mouse_check_button_pressed(mb_left);
var is_mouse_hover = collision_point(global.level_maker_mouse_x,global.level_maker_mouse_y,self,false,false);
if is_mouse_hover {
	switch (image_index) {
		case 1:  oLevelMaker.hover_text = LANG.maker_change_up;			break;
		case 2:  oLevelMaker.hover_text = LANG.maker_change_down;		break;
		case 3:  oLevelMaker.hover_text = LANG.maker_menu;				break;
		case 4:  oLevelMaker.hover_text = LANG.maker_savemenu;			break;
		case 5:  oLevelMaker.hover_text = LANG.maker_load;				break;
		case 6:  oLevelMaker.hover_text = LANG.maker_play;				break;
		case 7:  oLevelMaker.hover_text = LANG.maker_help;				break;
		case 8: //get style text
			switch (oLevelMaker.style_selected)
			{
				case LEVEL_STYLE.GRASS:		stext = LANG.maker_grassstyle;		break;
				case LEVEL_STYLE.CLOUDS:	stext = LANG.maker_cloudstyle;		break;
				case LEVEL_STYLE.FLOWERS:	stext = LANG.maker_flowerstyle;		break;
				case LEVEL_STYLE.SPACE:		stext = LANG.maker_spacestyle;		break;
				case LEVEL_STYLE.DUNGEON:	stext = LANG.maker_dungeonstyle;	break;
			}
			oLevelMaker.hover_text= LANG.maker_change_level_style +":\n"+ stext;
			break;
		case 9:  oLevelMaker.hover_text= LANG.maker_eraser;				break;
		case 10: oLevelMaker.hover_text= LANG.maker_erase_level;		break;
	}
	
	if oLevelMaker.cursor != LEVEL_CURSOR_TYPE.ERASER {
		oLevelMaker.cursor = LEVEL_CURSOR_TYPE.FINGER
	}
	
	if (mouse_check_button(mb_left)) {
		drawplus=2
	}
	
} else {
	holding=0; 
	is_mouse_left_pressing=false
}

// =============================
// ALL BUTTON FUNCTIONS
// =============================

// None
// if image_index == 0 and is_mouse_left_pressing {}

// Move object group up
if image_index == 1 and (is_mouse_left_pressing or key_down or mouse_wheel_down())
{
	with(oLevelMaker)
	{
		yplus=-4
	    currentx-=1
		repeat(maxx) {if currentx<0 {currentx=selectmaxx} if curobj=noone currentx-=1}
		audio_play_sfx(snd_morcego_02,false,-20,13)
		oButtonMakerObj.drawplus=-1
	}
}

// Move object group down
if image_index == 2 and (is_mouse_left_pressing or key_up or mouse_wheel_up()) {
	with(oLevelMaker)
	{
		yplus = 4
	    currentx += 1
		repeat(maxy) {
			if currentx > selectmaxx then currentx = 0;
			if curobj = noone then currenty += 1;
		}
		audio_play_sfx(snd_morcego_02,false,-20,13)
		oButtonMakerObj.drawplus=+1
	}
}

// Save level
if image_index == 4 and (is_mouse_left_pressing or (keyboard_check(vk_lcontrol) and keyboard_check_pressed(ord("S")))) {
	audio_play_sfx(sndUiChange,false,-18.3,1)
	d_levelName = get_save_filename("*.moonlevel","mylevel");
	if (d_levelName != "") then save_level(d_levelName);
}

// Load level
 if image_index == 5 and is_mouse_left_pressing {
	audio_play_sfx(sndUiChange,false,-18.3,1)
	d_loadLevel = get_open_filename("*.moonlevel","mylevel");
	if (d_loadLevel != "") then load_level(d_loadLevel);
}

// Test
if image_index == 6 and (is_mouse_left_pressing or keyboard_check_pressed(vk_space)) {
	audio_play_sfx(sndUiChange,false,-18.3,1)
	if instance_exists(oPause) //editor is opened 
	{
		with(oLevelMaker) {
			var has_player_in_level =
				object_of_type_exists_in_editor(oPlayer) 
				or object_of_type_exists_in_editor(oPlayerDir) 
				or object_of_type_exists_in_editor(oPlayerNeutral) 
				or object_of_type_exists_in_editor(oPlayerEnding);
			
			var has_star_in_level = 
				object_of_type_exists_in_editor(oStar) 
				or object_of_type_exists_in_editor(oStarColor) 
				or object_of_type_exists_in_editor(oStarRunning) 
				or object_of_type_exists_in_editor(oStarRunningColor) 
				or object_of_type_exists_in_editor(oStarFly) 
				or object_of_type_exists_in_editor(oStarColorNight);
		
			if has_player_in_level and has_star_in_level {
				start_level();
			} else {
				if not has_player_in_level then show_message_async(LANG.maker_noplayer);
				if not has_star_in_level then show_message_async(LANG.maker_noestar);
			}
		}
	} else {
		oLevelMaker.end_level_and_return_to_editor();
	}
}

// Help
if image_index == 7 and is_mouse_left_pressing {
	audio_play_sfx(sndUiChange,false,-18.3,1)
	
	show_message_async(LANG.maker_help_text)
}

// Change style
if image_index == 8 and is_mouse_left_pressing {
	audio_play_sfx(sndUiChange,false,-18.3,1)
	
	with(oLevelMaker) {
		style_selected += 1
		if style_selected >= LEVEL_STYLE.LENGTH then style_selected = 0
		scr_update_style()
	}
}

// Eraser
if image_index == 9 and is_mouse_left_pressing {
	audio_play_sfx(sndUiChange,false,-18.3,1)
	oLevelMaker.cursor = LEVEL_CURSOR_TYPE.ERASER;
}

// Clear level
if image_index == 10 {
	if mouse_check_button(mb_left) {
		holding += 0.05
		if holding == 4 {
			audio_play_sfx(sfx_luano_death_pause_01,false,-8.79,5) room_restart()
		}
	} else {
		holding = 0
	}

}