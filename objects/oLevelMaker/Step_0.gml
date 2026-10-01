if mode == LEVEL_MAKER_EDITOR_MODE.PLAYING {
  if (instance_exists(oPlayer) and not oPlayer.state.state_is("win"))
  and not instance_exists(oPauseUI)
  and not (instance_exists(oMakerTransition) and not oMakerTransition.state_machine.state_is("fade_in")) {
    time_played_timer.count();
  }
  
  if not instance_exists(oPlayer) and not instance_exists(oMakerTransition) {
    var _transition = maker_transition_start(room);
    
    if selected_style == LEVEL_MAKER_STYLE.FLOWERS
    or selected_style == LEVEL_MAKER_STYLE.SPACE
    or selected_style == LEVEL_MAKER_STYLE.DUNGEON {
      _transition.transition_background_color = c_black;
    }
    
    _transition.on_end_fade_out = function() {
      oLevelMaker.reset_level();
    };
  }
  exit;
}

item_preview_offset_y = smooth_approach(item_preview_offset_y, 0, 0.25);
item_preview_offset_x = smooth_approach(item_preview_offset_x, 0, 0.25);

item_place_disable_timer.count();

var _hover_button = collision_point(global.level_maker_mouse_x, global.level_maker_mouse_y, oButtonMaker, false, true);

if cursor != LEVEL_MAKER_CURSOR.ERASER {
	var _cursor = LEVEL_MAKER_CURSOR.CURSOR;
	
	var _hover_button_object = collision_point(global.level_maker_mouse_x, global.level_maker_mouse_y, oButtonMakerObj, false, true);
	
	_cursor = LEVEL_MAKER_CURSOR.CURSOR;
	
	if _hover_button
	or (_hover_button_object and _hover_button_object.is_active) {
		_cursor = LEVEL_MAKER_CURSOR.FINGER;
	}
	
	if current_layer == LEVEL_MAKER_LAYERS.OBJECTS
	and object_grid_hovering != -1 {
		_cursor = not is_undefined(selected_object) 
      and selected_object.has_tag("is_holdable") ? LEVEL_MAKER_CURSOR.CANCEL : LEVEL_MAKER_CURSOR.FINGER;
	}
	
	cursor = _cursor;
}

if _hover_button != noone {
  set_hover_text(_hover_button.hover_text);
} else {
  set_hover_text("");
}

check_return_to_editor_timer();

// If the level editor is not in use don't run any more code
if not level_maker_is_editing() or instance_exists(oPauseUI) then exit;

// This code is to prevent random misfiring clicks after you press the button to play the level again
if just_entered_level_editor and key_cursor_left_click_released {
	just_entered_level_editor = false;
	exit;
}

//----------------------------------------
// ACTUAL EDITOR CODE FROM HERE...
//----------------------------------------

// Only gets input if not paused

scr_inputget();

// ------------------------------------
// Selecting objects
// ------------------------------------
set_objects_list_navigation();
set_tiles_list_navigation();
update_tilesets_by_style();

sprite_index = is_undefined(selected_object) ? -1 : object_get_sprite(selected_object.index);
cursor_object_hovering = selected_object;

// Check the object that is behind the cursor
object_grid_hovering = get_grid_object_hovering(global.level_maker_mouse_x, global.level_maker_mouse_y);

// ------------------------------------
// Object rotation, mirroring and scaling
// ------------------------------------
set_object_rotation_and_scaling();
set_tile_manipulation();

// ------------------------------------
// Tiled mouse calculation setting
// ------------------------------------
is_cursor_inside_level = global.level_maker_mouse_x > 0
	and global.level_maker_mouse_x < 320
	and global.level_maker_mouse_y > 0
	and global.level_maker_mouse_y < 180;

var _selected_object_sprite = -1,
    _tile_scale = not is_undefined(selected_object) and selected_object.has_tag("grid_16") ? 2 : 1;

if not is_undefined(selected_object) {
    _selected_object_sprite = object_get_sprite(selected_object.index);
}

var _object_width = 1,
    _object_height = 1,
    _sprite_offset_x = _selected_object_sprite == -1 ? 0 : sprite_get_xoffset(_selected_object_sprite),
    _sprite_offset_y = _selected_object_sprite == -1 ? 0 : sprite_get_yoffset(_selected_object_sprite);

if is_undefined(selected_object) {
  _sprite_offset_x = 0;
  _sprite_offset_y = 0;
} else {
  var _size = selected_object.get_tiled_size_and_sprite_offset(tile_size, _object_width, _object_height);
  
  _object_width = _size.tiled_width;
  _object_height = _size.tiled_height;
  _sprite_offset_x = _size.sprite_x_offset;
  _sprite_offset_y = _size.sprite_y_offset;
}

var _selected_object_mouse_tile_x = round((global.level_maker_mouse_x - _object_width * tile_size / 2) / (_tile_scale * tile_size)) * _tile_scale,
    _selected_object_mouse_tile_y = round((global.level_maker_mouse_y - _object_height * tile_size / 2) / (_tile_scale * tile_size)) * _tile_scale;

_selected_object_mouse_tile_x = clamp(_selected_object_mouse_tile_x,0, room_tile_width - _object_width);
_selected_object_mouse_tile_y = clamp(_selected_object_mouse_tile_y,0, room_tile_height - _object_height);

var _new_offset = rotate_object_offset(
  _object_width,
  _object_height,
  _sprite_offset_x,
  _sprite_offset_y,
  image_angle
);

_sprite_offset_x = _new_offset.sprite_x_offset;
_sprite_offset_y = _new_offset.sprite_y_offset;

//placing objects with centered visuals
x = _selected_object_mouse_tile_x * tile_size + _sprite_offset_x;
y = _selected_object_mouse_tile_y * tile_size + _sprite_offset_y;

if current_layer != LEVEL_MAKER_LAYERS.OBJECTS {
	x = global.level_maker_mouse_x;
	y = global.level_maker_mouse_y;
}

// ------------------------------------
// MOUSE ACTIONS
// ------------------------------------
has_object_below_cursor = check_for_objects_in_grid_position(_selected_object_mouse_tile_x, _selected_object_mouse_tile_y, selected_object);

if instance_exists_any([oPauseUI, oMessagePopup, oTransition, oMakerTransition])
or mode == LEVEL_MAKER_EDITOR_MODE.PLAYING {
  exit;
}

cursor_get_object_from_grid();
cursor_create_object_in_grid(_selected_object_mouse_tile_x, _selected_object_mouse_tile_y);
cursor_remove_object_from_grid();

cursor_create_tile_in_grid();
cursor_remove_tile_from_grid();