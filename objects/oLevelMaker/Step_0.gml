item_preview_offset_y = smooth_approach(item_preview_offset_y, 0, 0.25);
item_preview_offset_x = smooth_approach(item_preview_offset_x, 0, 0.25);

item_place_disable_timer.count();

var _hover_button = collision_point(global.level_maker_mouse_x, global.level_maker_mouse_y, oButtonMaker, false, true);

if cursor != LEVEL_CURSOR_TYPE.ERASER {
	var _cursor = LEVEL_CURSOR_TYPE.CURSOR;
	
	var _hover_button_object = collision_point(global.level_maker_mouse_x, global.level_maker_mouse_y, oButtonMakerObj, false, true);
	
	_cursor = LEVEL_CURSOR_TYPE.CURSOR;
	
	if _hover_button
	or _hover_button_object {
		_cursor = LEVEL_CURSOR_TYPE.FINGER;
	}
	
	if current_layer == LEVEL_CURRENT_LAYER.OBJECTS
	and object_grid_hovering != -1 {
		_cursor = not is_undefined(selected_object) 
      and selected_object.has_tag("is_holdable") ? LEVEL_CURSOR_TYPE.CANCEL : LEVEL_CURSOR_TYPE.FINGER;
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
if not level_maker_is_editing() or instance_exists_any([oPauseMenu, oMakerWarning]) then exit;

// This code is to prevent random misfiring clicks after you press the button to play the level again
if just_entered_level_editor and mouse_check_button_released(mb_left) {
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
set_list_navigation();
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

var _selected_object_sprite = -1;
var _tile_scale = not is_undefined(selected_object) and selected_object.has_tag("grid_16") ? 2 : 1;

if not is_undefined(selected_object) {
    _selected_object_sprite = object_get_sprite(selected_object.index);
}

var _object_width = 1;
var _object_height = 1;
var _sprite_offset_x = _selected_object_sprite == -1 ? 0 : sprite_get_xoffset(_selected_object_sprite);
var _sprite_offset_y = _selected_object_sprite == -1 ? 0 : sprite_get_yoffset(_selected_object_sprite);

var _size = is_undefined(selected_object) ? [1, 1, 0, 0] : selected_object.get_size(tile_size, _object_width, _object_height);

_object_width = _size[0];
_object_height = _size[1];
_sprite_offset_x = _size[2];
_sprite_offset_y = _size[3];

var _selected_object_mouse_tile_x = round((global.level_maker_mouse_x - _object_width * tile_size / 2) / (_tile_scale * tile_size)) * _tile_scale;
var _selected_object_mouse_tile_y = round((global.level_maker_mouse_y - _object_height * tile_size / 2) / (_tile_scale * tile_size)) * _tile_scale;

_selected_object_mouse_tile_x = clamp(_selected_object_mouse_tile_x,0, room_tile_width - _object_width);
_selected_object_mouse_tile_y = clamp(_selected_object_mouse_tile_y,0, room_tile_height - _object_height);

var _new_offset = rotate_object_offset(_object_width,_object_height,_sprite_offset_x,_sprite_offset_y,image_angle);

_sprite_offset_x = _new_offset[0];
_sprite_offset_y = _new_offset[1];

//placing objects with centered visuals
x = _selected_object_mouse_tile_x * tile_size + _sprite_offset_x;
y = _selected_object_mouse_tile_y * tile_size + _sprite_offset_y;

if current_layer != LEVEL_CURRENT_LAYER.OBJECTS {
	x = global.level_maker_mouse_x;
	y = global.level_maker_mouse_y;
}

// ------------------------------------
// MOUSE ACTIONS
// ------------------------------------
has_object_below_cursor = check_for_objects_in_grid_position(_selected_object_mouse_tile_x, _selected_object_mouse_tile_y, selected_object);

cursor_get_object_from_grid();
cursor_create_object_in_grid(_selected_object_mouse_tile_x, _selected_object_mouse_tile_y);
cursor_remove_object_from_grid();

cursor_create_tile_in_grid();
cursor_remove_tile_from_grid();