scr_inputget();
// You can write your code in this editor
drawx=random_range(-(holding),(holding))
drawy=random_range(-(holding),(holding))
drawtarget=0

//lerp play button position to be visible in play state
if image_index == 6 { //play button
	
    //editor is opened
	if instance_exists(oPause) { 
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
	if not instance_exists(oPause) then exit
}

var stext = "";
switch (image_index) {
    case 1:  hover_text = LANG.maker_change_up;			break;
    case 2:  hover_text = LANG.maker_change_down;		break;
    case 3:  hover_text = LANG.maker_menu;				break;
    case 4:  hover_text = LANG.maker_savemenu;			break;
    case 5:  hover_text = LANG.maker_load;				break;
    case 6:  hover_text = LANG.maker_play;				break;
    case 7:  hover_text = LANG.maker_help;				break;
    case 8: //get style text
        switch (oLevelMaker.selected_style) {
            case LEVEL_STYLE.GRASS:		stext = LANG.maker_grassstyle;		break;
            case LEVEL_STYLE.CLOUDS:	stext = LANG.maker_cloudstyle;		break;
            case LEVEL_STYLE.FLOWERS:	stext = LANG.maker_flowerstyle;		break;
            case LEVEL_STYLE.SPACE:		stext = LANG.maker_spacestyle;		break;
            case LEVEL_STYLE.DUNGEON:	stext = LANG.maker_dungeonstyle;	break;
        }
        hover_text = $"{LANG.maker_change_level_style}\n{stext}";
        break;
    case 9:  hover_text = LANG.maker_eraser; break;
    case 10: hover_text = LANG.maker_erase_level; break;
    case 11: hover_text = $"Change Layer:\n{level_maker_get_layer_hover_text()}"; break;
}

var is_mouse_left_pressing = mouse_check_button_pressed(mb_left);
var is_mouse_hover = collision_point(global.level_maker_mouse_x,global.level_maker_mouse_y,self,false,false);
if is_mouse_hover and mouse_check_button(mb_left) { 
    drawplus = 2;
} else {
	holding = 0; 
	is_mouse_left_pressing = false;
}
// =============================
// ALL BUTTON FUNCTIONS
// =============================

// None
// if image_index == 0 and is_mouse_left_pressing {}

// Move object group up
if image_index == 1 and (is_mouse_left_pressing or key_down or mouse_wheel_up())
{
	with(oLevelMaker)
	{
		var _pages_length = current_layer == LEVEL_CURRENT_LAYER.OBJECTS ? array_length(obj) - 1 : array_length(tiles) - 1;
		
		audio_play_sfx(snd_morcego_02, false, -20, 13);
		
		item_preview_offset_y = -4;
	    selected_object_type -= 1;
		repeat(_pages_length) {
			if selected_object_type < 0 then
				selected_object_type = _pages_length;
			if selected_object == noone then
				selected_object_type -= 1;
		}
		
		oButtonMakerObj.drawplus = -1;

        with(oLevelMaker) {
            image_xscale = 1;
            image_yscale = 1;
            image_angle = 0;
            update_current_item();
        }
	}
}

// Move object group down
if image_index == 2 and (is_mouse_left_pressing or key_up or mouse_wheel_down()) {
	with(oLevelMaker) {
		var _pages_length = current_layer == LEVEL_CURRENT_LAYER.OBJECTS ? array_length(obj) - 1 : array_length(tiles) - 1;
		
		audio_play_sfx(snd_morcego_02, false, -20, 13);
		
		item_preview_offset_y = 4;
	    selected_object_type += 1;
		
		repeat(list_positions_length - 1) {
			if selected_object_type > _pages_length then
				selected_object_type = 0;
			if selected_object = noone then 
				selected_object_position += 1;
		}
		
		oButtonMakerObj.drawplus = 1

		with(oLevelMaker) {
            image_xscale = 1;
            image_yscale = 1;
            image_angle = 0;
            update_current_item();
        }
	}
}

// Save level
if image_index == 4 and (is_mouse_left_pressing or (keyboard_check(vk_lcontrol) and keyboard_check_pressed(ord("S")))) {
	play_sound_on_press();
	d_levelName = get_save_filename("*.moonlevel","mylevel");
	if (d_levelName != "") then level_maker_save(d_levelName);
}

// Load level
 if image_index == 5 and is_mouse_left_pressing {
	play_sound_on_press();
	d_loadLevel = get_open_filename("*.moonlevel","mylevel");
	if (d_loadLevel != "") then level_maker_load(d_loadLevel);
}

// Test
if image_index == 6 and (is_mouse_left_pressing or keyboard_check_pressed(vk_f5)) {
	play_sound_on_press();
	
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
		oLevelMaker.reset_test_button_cooldown();
		oLevelMaker.end_level_and_return_to_editor();
	}
}

// Help
if image_index == 7 and is_mouse_left_pressing {
	play_sound_on_press();
	
	show_message_async(LANG.maker_help_text)
}

// Change style
if image_index == 8 and is_mouse_left_pressing {
	play_sound_on_press();
	
	with(oLevelMaker) {
		selected_object_type = 0;
		selected_object_position = 0;
		
		selected_style += 1;
		if selected_style >= LEVEL_STYLE.LENGTH then 
			selected_style = 0;
			
		tiles = level_maker_get_tiles_list(selected_style);

		scr_update_style();
        update_current_item();
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
			audio_play_sfx(sfx_luano_death_pause_01, false, -8.79, 5);
			room_restart();
		}
	} else {
		holding = 0;
	}
}

// Change layer
if image_index == 11 and is_mouse_left_pressing {
	play_sound_on_press();
	
	with(oLevelMaker) {
		selected_object = undefined;
		selected_object_type = 0;
		selected_object_position = 0;
		
		current_layer -= 1;
		if current_layer < 0 then
			current_layer = LEVEL_CURRENT_LAYER.BACKGROUND_4;

        update_current_item();
	}
}