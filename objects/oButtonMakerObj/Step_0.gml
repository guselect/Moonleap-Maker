scr_inputget();

drawtarget = 0;

if oLevelMaker.current_layer == LEVEL_MAKER_LAYERS.OBJECTS {
  with(oLevelMaker) {
    other.object = obj[selected_object_type, other.index];
  }
	
	is_active = not is_undefined(object);

	visible = is_active;
	sprite_index = not is_active ? -1 : object_get_sprite(object.index);
} else {
  with(oLevelMaker) {
    other.tile = tiles[selected_tile_type, other.index];
  }
	
	is_active = not is_undefined(tile) or tile <= 0;
	visible = is_active;
	sprite_index = -1;
}

xx = round(xstart - 8)
yy = round(ystart - 8)

if sprite_xoffset > 6 {
	xx += 8;
}

if sprite_yoffset > 6 {
	yy += 8;
}

scale = 1;

switch(sprite_index) {
	case sGemFly:
	case sGemGrayUI:
		yy += 3;
		break;
	case sBird:
		yy += 8;
		break;
	case sTestDay:
	case sTestNight:
		xx -= 8;
		yy -= 8;
		break;
}

var _selected_layer = oLevelMaker.current_layer;

if (_selected_layer == LEVEL_MAKER_LAYERS.OBJECTS
	and object == oLevelMaker.obj[oLevelMaker.selected_object_type, oLevelMaker.selected_object_position]
) or (_selected_layer != LEVEL_MAKER_LAYERS.OBJECTS
	and tile == oLevelMaker.tiles[oLevelMaker.selected_tile_type, oLevelMaker.selected_tile_position]
) {
	drawtarget = -2;
}

drawplus = smooth_approach(drawplus, drawtarget, 0.25);

if instance_exists_any([oPauseUI, oMessagePopup, oTransition, oMakerTransition])
or oLevelMaker.mode == LEVEL_MAKER_EDITOR_MODE.PLAYING {
  exit;
}

var _mouse_x = global.level_maker_mouse_x,
    _mouse_y = global.level_maker_mouse_y,
    _button_left = xstart - 12,
    _button_top = ystart - 32,
    _button_right = xstart + 12,
    _button_bottom = ystart + 32;

if is_active
and point_in_rectangle(_mouse_x, _mouse_y, _button_left, _button_top, _button_right, _button_bottom)
and key_cursor_left_click_pressed {
  shake_gamepad(0.4, 4);
  audio_play_sfx(sndUiChange, false, -18.3, 1);
  with(oLevelMaker) {
    cursor = LEVEL_MAKER_CURSOR.FINGER;
    if current_layer == LEVEL_MAKER_LAYERS.OBJECTS {
      selected_object_position = other.index;  
    } else {
      selected_tile_position = other.index;
    }
    
    image_xscale = 1;
    image_yscale = 1;
    image_angle = 0;
    update_current_item();
  }
}