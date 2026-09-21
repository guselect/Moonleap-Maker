enum LEVEL_MAKER_BUTTON_TYPE {
  BLANK,
  PAGE_UP,
  PAGE_DOWN,
  MENU,
  SAVE_LEVEL,
  LOAD_LEVEL,
  TEST_LEVEL,
  HELP,
  CHANGE_STYLE,
  ERASER,
  CLEAR_LEVEL,
  CHANGE_LAYER
}

scr_inputcreate();

xs = x;
ys = y;
drawy = 0;
drawx = 0;
scale = 1;

holding_button_frames = 0;
holding_button_step_frames = 0.05;
holding_button_max_frames = 4;

test_level_button_frames = 0;
test_level_button_step_frames = 0.05;
test_level_button_max_frames = 2.5;
test_level_button_reached_max = false;

has_cleared_level = false;

start_pos_x = x;
start_pos_y = y;

small_size = 20;

drawplus = 0;
drawtarget = 0;
hover_text = "";

__play_sound_on_press = function() {
  var _sound = sndUiChange,
      _can_loop = false,
      _gain = -18.3,
      _pitch = 1;

	audio_play_sfx(_sound, _can_loop, _gain, _pitch);
};

__play_sound_on_page_change = function() {
  var _sound = snd_morcego_02,
      _can_loop = false,
      _gain = -20,
      _pitch = 13;

  audio_play_sfx(_sound, _can_loop, _gain, _pitch);
};

__shake_gamepad_on_press = function() {
  var _intensity = 0.4;
      _duration = 4;
  
  shake_gamepad(_intensity, _duration);
};

__shake_gamepad_on_clear_level = function() {
  var _intensity = clamp((holding_button_frames / holding_button_max_frames) + 0.3, 0, 1),
      _duration = 2;
  
  shake_gamepad(_intensity, _duration);
};

__change_style = function() {
  with(oLevelMaker) {
		selected_object_type = 0;
		selected_object_position = 0;
    
    selected_tile_type = 0;
		selected_tile_position = 0;
		
		selected_style += 1;
		if selected_style >= LEVEL_MAKER_STYLE.LENGTH {
  	  selected_style = 0;
    } 
		
		tiles = level_maker_get_tiles_list(selected_style);

		level_maker_update_style();
    update_current_item();
    reset_level_tiles_grid();
	}
};

__update_hover_text = function() {
  var _style_text = "";

  switch (image_index) {
    case LEVEL_MAKER_BUTTON_TYPE.PAGE_UP:
      hover_text = LANG.maker_change_up;
    break;
  
    case LEVEL_MAKER_BUTTON_TYPE.PAGE_DOWN:
      hover_text = LANG.maker_change_down;
    break;
  
    case LEVEL_MAKER_BUTTON_TYPE.MENU:
      hover_text = LANG.maker_menu;
    break;
  
    case LEVEL_MAKER_BUTTON_TYPE.SAVE_LEVEL:
      hover_text = LANG.maker_savemenu;
    break;
  
    case LEVEL_MAKER_BUTTON_TYPE.LOAD_LEVEL:
      hover_text = LANG.maker_load;
    break;
  
    case LEVEL_MAKER_BUTTON_TYPE.TEST_LEVEL:
      hover_text = LANG.maker_play;
    break;
  
    case LEVEL_MAKER_BUTTON_TYPE.HELP:
      hover_text = LANG.maker_help;
    break;
    case LEVEL_MAKER_BUTTON_TYPE.CHANGE_STYLE:
      switch (oLevelMaker.selected_style) {
          case LEVEL_MAKER_STYLE.GRASS:		_style_text = LANG.maker_grassstyle;		break;
          case LEVEL_MAKER_STYLE.CLOUDS:	_style_text = LANG.maker_cloudstyle;		break;
          case LEVEL_MAKER_STYLE.FLOWERS:	_style_text = LANG.maker_flowerstyle;		break;
          case LEVEL_MAKER_STYLE.SPACE:		_style_text = LANG.maker_spacestyle;		break;
          case LEVEL_MAKER_STYLE.DUNGEON:	_style_text = LANG.maker_dungeonstyle;	break;
      }
      hover_text = $"{LANG.maker_change_level_style}\n{_style_text}";
    break;
  
    case LEVEL_MAKER_BUTTON_TYPE.ERASER:
      hover_text = LANG.maker_eraser;
    break;
  
    case LEVEL_MAKER_BUTTON_TYPE.CLEAR_LEVEL:
      hover_text = LANG.maker_erase_level;
    break;
  
    case LEVEL_MAKER_BUTTON_TYPE.CHANGE_LAYER:
      hover_text = $"{LANG.maker_change_layer}\n{level_maker_get_layer_hover_text()}";
    break;
  }
};


// ==========================================
// BUTTONS' ACTIONS
// ==========================================
__action_items_page_up = function() {
  __shake_gamepad_on_press();
  __play_sound_on_page_change();
  
  with(oLevelMaker) {
    var _pages_length = 0;
    
    if current_layer == LEVEL_MAKER_LAYERS.OBJECTS {
      _pages_length = array_length(obj) - 1;
      
      selected_object_position = 0; 
      selected_object_type -= 1;
      
  		repeat(_pages_length) {
  			if selected_object_type < 0 then
  				selected_object_type = _pages_length;
  			if selected_object = noone then 
  				selected_object_position -= 1;
  		}
    } else {
      _pages_length = array_length(tiles) - 1;
      
      selected_tile_position = 0; 
      selected_tile_type -= 1;
  		repeat(_pages_length) {
  			if selected_tile_type < 0 then
  				selected_tile_type = _pages_length;
  			if is_undefined(selected_tile) then 
  				selected_tile_position -= 1;
  		}
    }
    
		oButtonMakerObj.drawplus = -1;
    image_xscale = 1;
    image_yscale = 1;
    image_angle = 0;
    update_current_item();
	}
};

__action_items_page_down = function() {
  __shake_gamepad_on_press();
  __play_sound_on_page_change();
  with(oLevelMaker) {
    item_preview_offset_y = 4;
    
    var _pages_length = 0;
    
    if current_layer == LEVEL_MAKER_LAYERS.OBJECTS {
      _pages_length = array_length(obj) - 1;
      
      selected_object_position = 0; 
      selected_object_type += 1;
      
  		repeat(_pages_length) {
  			if selected_object_type > _pages_length then
  				selected_object_type = 0;
  			if selected_object = noone then 
  				selected_object_position += 1;
  		}
    } else {
      _pages_length = array_length(tiles) - 1;
      
      selected_tile_position = 0; 
      selected_tile_type += 1;
  		repeat(_pages_length) {
  			if selected_tile_type > _pages_length then
  				selected_tile_type = 0;
  			if is_undefined(selected_tile) then 
  				selected_tile_position += 1;
  		}
    }

    image_xscale = 1;
    image_yscale = 1;
    image_angle = 0;
    update_current_item();
		oButtonMakerObj.drawplus = 1;
	}
};

__action_menu = function() {
  __shake_gamepad_on_press();
  __play_sound_on_press();
  
  var _menu_list = menus_get_level_editor(),
      _first_menu_name = "main",
      _layer_name = "Instances",
      _fill_background = true,
      _show_game_version = false,
      _show_title = true,
      _use_alt_colors = true;
  
	var _menu = menu_call_layer(
    _menu_list,
    _first_menu_name,
    _layer_name,
    _fill_background,
    _show_game_version,
    _show_title,
    _use_alt_colors
  );
  
  _menu.on_clean_up = function() {
    with (oLevelMaker) {
      item_place_disable_timer.reset();  
    }
  }
};

__action_save_level = function() {
  var _is_level_valid = level_maker_check_level_validation();
  
  if not _is_level_valid {
    message_popup_call_level_requirements(true);
    return;
  }
  __shake_gamepad_on_press();
  __play_sound_on_press();
  menu_call_layer(menus_get_save_level(), "main", "Instances", true, false, false, true);
};

__action_load_level = function() {
  __play_sound_on_press();
  __shake_gamepad_on_press();
  
  var _level_file_name = get_open_filename($"*.{LEVEL_MAKER_LEVEL_FILE_EXTENSION}", "mylevelname");
  
  if _level_file_name == "" {
    return;
  }
  
  level_maker_load(_level_file_name);
  
  with (oLevelMaker) {
    item_place_disable_timer.reset();
  }
};

__action_test_level = function() {
  var _is_level_valid = level_maker_check_level_validation();
  
  if not _is_level_valid {
    message_popup_call_level_requirements();
    return;
  }
  
  __shake_gamepad_on_press();
  with(oLevelMaker) {
    if level_maker_is_editing() {
      start_level();
      audio_play_sfx(sndStarGame, false, -18.3, 1);
    } else {
      oLevelMaker.item_place_disable_timer.reset();
      oLevelMaker.end_level();
    }
  }
};

__action_help = function() {
  __play_sound_on_press();
  __shake_gamepad_on_press(); 
  call_message_info([
    LANG.maker_help_welcome,
    LANG.maker_help_creating_and_testing,
    LANG.maker_help_custom_config,
    LANG.maker_help_recommendations,
    LANG.maker_help_layers,
    LANG.maker_help_change_style1,
    LANG.maker_help_change_style2,
    LANG.maker_help_save_level,
    LANG.maker_help_load_level,
    LANG.maker_help_shortcut_keyboard1,
    LANG.maker_help_shortcut_keyboard2,
    LANG.maker_help_shortcut_controller1,
    LANG.maker_help_shortcut_controller2
  ], "Instances_2");
};

__action_change_style = function() {
  __play_sound_on_press();
  __shake_gamepad_on_press();
  if instance_number(oMakerEditorTileDraft) > 0 {
    var _warning = instance_create_layer(0, 0, "Instances_2", oMakerWarning);
    
    _warning.text_warning = LANG.maker_warning_change_style;
    _warning.action_on_confirm = __change_style;
  } else {
    __change_style();
  }
};

__action_eraser = function() {
  __play_sound_on_press();
  __shake_gamepad_on_press();
  oLevelMaker.cursor = LEVEL_MAKER_CURSOR.ERASER;
};

__action_clear_level = function() {
  var _is_left_pressing = key_cursor_left_click_pressing;

  if _is_left_pressing {
		if not has_cleared_level {
			holding_button_frames = min(
        holding_button_frames + holding_button_step_frames,
        holding_button_max_frames
      );
      
      if holding_button_frames < holding_button_max_frames {
        __shake_gamepad_on_clear_level();
      }
		
			if holding_button_frames == holding_button_max_frames {
				has_cleared_level = true;
				audio_play_sfx(sfx_luano_death_pause_01, false, -8.79, 5);
				with(oLevelMaker) {
          selected_style = LEVEL_MAKER_STYLE.GRASS;
          selected_object_type = 0;
          selected_object_position = 0;
					clear_level();
					set_sample_level();
				}
			}
		}
    return;
	}

  holding_button_frames = 0;
  has_cleared_level = false;
};

__action_change_layer = function() {
  __shake_gamepad_on_press();
  __play_sound_on_press();
  with(oLevelMaker) {
    selected_object = undefined;
    selected_object_type = 0;
    selected_object_position = 0;
    
    current_layer += 1;
    if current_layer > 3 then
      current_layer = LEVEL_MAKER_LAYERS.FOREGROUND;

    update_current_item();
  }
};
