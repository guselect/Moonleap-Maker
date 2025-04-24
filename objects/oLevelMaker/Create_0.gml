/* NOTES:

- This repository is based on Moonleap version 2.3.2, but with the SleepScreens removed and some levels missing, specifically Rooms 0 to 49.
- Rooms 60 to 63 were kept only as examples of how the levels in Moonleap were originally built.
- The maker_mode=true setting in the oIntro causes the game go straight to the RoomMaker0

- [DIDN'T FIND ANY OF THEM] Some objects just didnt pause when oPause exists, thats a bug
- [OKAY!] oSolidDay and oSolidNight were created for this levelmaker, in the game i use oGrassDay, oGrassNight, oCloudDay...
- [DONE!] the UI show plenty of oUndefined, it isn't ideal, need to do a solution for that
- [DONE!] Style stuff isn't done yet but the way enemies check what style of phase they are in is by checking if there is a GrassDay, CloudDay, FlowerDay and so on
based on that they update their colors
- [FIXED] oPlatGhost dont really rotate, in the game i use oPlatGhostL, oPlatGhostR and oPlatGhostInv...
- [NICE!] The plan is to eventually integrate Moonleap Maker into the Steam version of Moonleap, making it available as an option in the game menu
*/

// Input variables
scr_inputcreate()

mode = LEVEL_EDITOR_MODE.EDITING;

// User Level Config
level_name = "";
level_author_name = "";
use_night_music = false;
use_ranking_system = false;
rank_S_change_max = 0;

// Grid-related
tile_size = 8;
room_tile_width =  room_width div tile_size;
room_tile_height = (room_height div tile_size) + tile_size;
objects_grid = []; // Grid where the objects inserted by player are.

for(var _x = 0; _x < room_tile_width; _x++) {
	for(var _y = 0; _y < room_tile_height; _y++) {
		objects_grid[_x, _y] = -1;
	}	
}

// Cursor-related
cursor = LEVEL_CURSOR_TYPE.NOTHING;
cursor_object_hovering = undefined;
is_cursor_inside_level = false;
item_preview_offset_x = 0;
item_preview_offset_y = 0;
has_object_below_cursor = false;
test_button_cooldown_max = 20;
test_button_cooldown = test_button_cooldown_max;
reset_test_button_cooldown = function() {
	test_button_cooldown = test_button_cooldown_max;
}

// Level-related
selected_style = LEVEL_STYLE.GRASS;
//time = 0; //used to release the buttons

// UI-related
hover_text = "";
text_shadow_x = 2;
text_shadow_y = 1;
color = {
	nice_black: make_color_rgb(0,0,72),
	nice_white: make_color_rgb(170,255,255),
	nice_blue: $FFFFAA55,
};

// List-related
current_layer = LEVEL_CURRENT_LAYER.OBJECTS;
list_positions_length = 16;

// Tileset-related
tiles = level_maker_get_tiles_list(selected_style);
selected_tile = undefined;
cursor_tile_hovering = undefined;
tileset_size = 16;

// Objects-related
obj = level_maker_get_objects_list();
selected_object = 0;
selected_object_type = 0;
selected_object_position = 0;
default_sprite_origin = SPRITE_ORIGIN.TOP_LEFT;
object_grid_hovering = -1; // Object where cursor is above at.

object_types_length = array_length(obj);

set_hover_text = function(_hover_text) {
    hover_text = _hover_text;
}

set_list_navigation = function() {
	var ui_nav_x = key_right_pressed - key_left_pressed;
	
	if ui_nav_x == 0 then return;

	item_preview_offset_x = 2 * sign(ui_nav_x);
	selected_object_position += sign(ui_nav_x);
	
	while selected_object_position < 0 
		or selected_object_position > list_positions_length - 1 
		or is_undefined(obj[selected_object_type, selected_object_position])
	{
		selected_object_position += sign(ui_nav_x);
		
		if selected_object_position < 0 then 
			selected_object_position = list_positions_length - 1;
		else if selected_object_position > list_positions_length - 1 then 
			selected_object_position = 0;
	}
	
	audio_play_sfx(snd_bump, false, -5, 13);

	selected_object = obj[selected_object_type, selected_object_position];
}

update_selected_object = function() {
    selected_object = array_get(obj[selected_object_type], selected_object_position);
}

update_selected_tile = function() {
    selected_tile = variable_clone(array_get(tiles[selected_object_type], selected_object_position));
}

update_current_item = function() {
    if current_layer == LEVEL_CURRENT_LAYER.OBJECTS {
        update_selected_object();
    } else {
        update_selected_tile();
    }
}

cursor_set_position = function() {
	var _in_level_editor = instance_exists(oPause);

	camera_current_interpolation += _in_level_editor ? -0.07 : 0.07;
	camera_current_interpolation = clamp(camera_current_interpolation, 0, 1);

	// Recalculate the mouse position since I'm using oAppSurfaceManager to resize the application surface to keep it pixel perfect
	// this is instead of using the actual camera cause then it would look ugly zoomed in

	var _cam_offset_x = camera_get_view_x(view_camera[0]);
	var _cam_offset_y = camera_get_view_y(view_camera[0]);
	
	var _cam_width = camera_get_view_width(view_camera[0]);
	var _cam_height = camera_get_view_height(view_camera[0]);
	
	var _app_surface_x = lerp(0, _cam_offset_x, camera_current_interpolation);
	var _app_surface_y = lerp(0, _cam_offset_y, camera_current_interpolation);
	
	var _gui_scale_x = lerp(1,  _cam_width/room_width, camera_current_interpolation);
	var _gui_scale_y = lerp(1,  _cam_height/room_height, camera_current_interpolation);

	global.level_maker_mouse_x = (mouse_x - _app_surface_x) / _gui_scale_x;
	global.level_maker_mouse_y = (mouse_y - _app_surface_y) / _gui_scale_y;
}

cursor_get_object_from_grid = function() {
	if not is_cursor_inside_level
	or current_layer != LEVEL_CURRENT_LAYER.OBJECTS
	or not mouse_check_button_pressed(mb_left)
	or cursor != LEVEL_CURSOR_TYPE.FINGER
	or not is_struct(object_grid_hovering)
	or selected_object.has_tag("is_holdable") then
		return;
	
	var _obj_pos = get_x_y_from_object_index(object_grid_hovering.object);
				
	selected_object_type = _obj_pos[0];
	selected_object_position = _obj_pos[1];
	image_xscale = object_grid_hovering.xscale;
	image_yscale = object_grid_hovering.yscale;
	image_angle = object_grid_hovering.angle;
		
	remove_object_from_grid(object_grid_hovering);
	update_selected_object();
}

cursor_create_object_in_grid = function(_tile_x, _tile_y) {
	if not is_cursor_inside_level or current_layer != LEVEL_CURRENT_LAYER.OBJECTS then
		return;
	
	if (mouse_check_button_released(mb_left) 
			or (mouse_check_button(mb_left) and selected_object.has_tag("is_holdable"))
		) and cursor == LEVEL_CURSOR_TYPE.CURSOR 
		and not is_undefined(selected_object)
		and not has_object_below_cursor
		and test_button_cooldown == 0
	{
		if selected_object.has_tag("is_unique") {
			remove_all_specific_objects_from_grid(selected_object.index);
		}
		
		if selected_object.index == oMagicOrb 
		or selected_object.index == oGrayOrb {
			remove_orb_from_grid();
		}
		
		place_object_in_object_grid(
			_tile_x,
			_tile_y,
			selected_object,
			oLevelMaker.image_xscale,
			oLevelMaker.image_yscale,
			oLevelMaker.image_angle
		);
		
		if instance_exists(oSolidDay) then oSolidDay.update = true;
		if instance_exists(oSolidNight) then oSolidNight.update = true;
		audio_play_sfx(snd_key2, false, -18.3, 20);
		
		repeat(3) {
			var sm = instance_create_layer(x + 8, y + 8, "Instances_2", oBigSmoke);
			
			sm.image_xscale=0.5;
			sm.image_yscale=0.5;
		}
	}
}

cursor_remove_object_from_grid = function() {
	if not is_cursor_inside_level or current_layer != LEVEL_CURRENT_LAYER.OBJECTS then
		return;
	
	if (mouse_check_button(mb_right) 
		or (mouse_check_button(mb_left) 
			and cursor == LEVEL_CURSOR_TYPE.ERASER))
		and is_struct(object_grid_hovering) 
	{
		remove_object_from_grid(object_grid_hovering);
		
		audio_play_sfx(snd_brokestone,false,-5,15);
		instance_create_layer(x + 8, y + 8, "Instances_2", oBigSmoke);
		instance_create_layer(x + 8, y + 8, "Instances_2", oBigSmoke);
	}
}

cursor_create_tile_in_grid = function() {
	if not is_cursor_inside_level or current_layer == LEVEL_CURRENT_LAYER.OBJECTS then
		return;

    if not mouse_check_button(mb_left)
    or cursor != LEVEL_CURSOR_TYPE.CURSOR
    or is_undefined(selected_tile)
    or test_button_cooldown > 0 {
        return;
    }

    var _instance_layer_name = level_maker_get_background_instances_layer_name();
    var _tileset_layer_name = level_maker_get_background_tile_layer_name();
    var _tilemap_id = layer_tilemap_get_id(_tileset_layer_name);

    if _tilemap_id == -1 then return;

    var _x = floor(x / tileset_size) * tileset_size;
    var _y = floor(y / tileset_size) * tileset_size;

    var _existing_tile_draft_list = ds_list_create();
    var _existing_tile_draft_amount = collision_rectangle_list(_x, _y, _x + tileset_size, _y + tileset_size, oMakerEditorDraft, false, true, _existing_tile_draft_list, true);

    for (var i = 0; i < _existing_tile_draft_amount; i++) {
        var _current_draft = ds_list_find_value(_existing_tile_draft_list, i);

        if layer_get_name(_current_draft.layer) == _instance_layer_name {
            ds_list_destroy(_existing_tile_draft_list);
            return;
        }
    }

    ds_list_destroy(_existing_tile_draft_list);

    var _is_animated_sprite = selected_tile.is_animated;

    // Cria um objeto de rascunho que será responsável por desenhar o tile na room
    var _tile_draft = instance_create_layer(_x, _y, _instance_layer_name, oMakerEditorDraft);
    _tile_draft.angle = image_angle;
    _tile_draft.xscale = image_xscale;
    _tile_draft.yscale = image_yscale;
    _tile_draft.type = _is_animated_sprite ? DRAFT_TYPE.ANIMATED_TILE : DRAFT_TYPE.TILE;
    _tile_draft.tile_id = selected_tile.original_tile_id;
    _tile_draft.tileset = selected_tile.tileset;
    _tile_draft.tilemap_id = _tilemap_id;
    _tile_draft.is_rotated = tile_get_rotate(selected_tile.tile_id);
    _tile_draft.is_mirrored = tile_get_mirror(selected_tile.tile_id);
    _tile_draft.is_flipped = tile_get_flip(selected_tile.tile_id);

    if _is_animated_sprite {
        _tile_draft.layer_id = layer_get_id(_instance_layer_name);
        _tile_draft.sprite_day = selected_tile.sprite_day;
        _tile_draft.sprite_night = selected_tile.sprite_night;
    }
    
    audio_play_sfx(snd_key2, false, -18.3, 20);
    
    repeat(3) {
        var sm = instance_create_layer(x + 8, y + 8, "Instances_2", oBigSmoke);
        sm.image_xscale = 0.5;
        sm.image_yscale = 0.5;
    }
}

cursor_remove_tile_from_grid = function() {
	if not is_cursor_inside_level or current_layer == LEVEL_CURRENT_LAYER.OBJECTS then
		return;
		
	if (not mouse_check_button(mb_left) and mouse_check_button(mb_right)) 
    or (mouse_check_button(mb_left) and cursor == LEVEL_CURSOR_TYPE.ERASER) {
		var _instance_layer_name = level_maker_get_background_instances_layer_name();
		var _x = floor(x / tileset_size) * tileset_size;
		var _y = floor(y / tileset_size) * tileset_size;
        var _tile_draft_list = ds_list_create();
        var _tile_draft_amount = collision_rectangle_list(_x, _y, _x + tileset_size, _y + tileset_size, oMakerEditorDraft, false, true, _tile_draft_list, true);
        var _tile_draft_to_remove = noone;

        for (var i = 0; i < _tile_draft_amount and _tile_draft_to_remove == noone; i++) {
            var _current_draft = ds_list_find_value(_tile_draft_list, i);
    
            if layer_get_name(_current_draft.layer) == _instance_layer_name {
                _tile_draft_to_remove = _current_draft;
            }
        }

        ds_list_destroy(_tile_draft_list);
        
        if _tile_draft_to_remove == noone {
            return;
        }

        instance_destroy(_tile_draft_to_remove);

        audio_play_sfx(snd_brokestone, false, -5, 15); 
        repeat(2) {
            instance_create_layer(x, y, "Instances_2", oBigSmoke);
        }
	}
}

update_tilesets_by_style = function() {
	if not instance_exists(oPause) then return;
	
	var _layers = level_maker_get_tileset_layers();
	
	var _tilemaps = [];
	var _tileset = undefined;
	
	for (var i = 0; i < array_length(_layers); i++) {
		var _layer = _layers[i];
		
		if _layer == -1 then continue;
		
		var _tilemap = layer_tilemap_get_id(_layer);
		
		if _tilemap == -1 then continue;
		
		switch(selected_style) {
			case LEVEL_STYLE.GRASS:
				_tileset = tMakerGrassDay;
				break;
			case LEVEL_STYLE.CLOUDS:
				_tileset = tMakerCloudDay;
				break;
			case LEVEL_STYLE.FLOWERS:
				_tileset = tMakerFlowerDay;
				break;
			case LEVEL_STYLE.SPACE:
				_tileset = tMakerSpaceDay;
				break;
			case LEVEL_STYLE.DUNGEON:
				_tileset = tMakerDungeonDay;
				break;
		}
		
		tilemap_tileset(_tilemap, _tileset);
	}
}

set_tile_manipulation = function() {
	if is_undefined(selected_tile) or current_layer == LEVEL_CURRENT_LAYER.OBJECTS then 
		return;
		
	var _tile = selected_tile.tile_id;
	
	// Rotate tile
	if keyboard_check_pressed(ord("Z")) {
		audio_play_sfx(sndPress, false, -5, 13);
		
		image_angle += 90;
		if image_angle >= 360 then 
			image_angle = 0;
		
		var _rotated_tile = _tile;
		switch(image_angle) {
			case 0:
				_rotated_tile = tile_set_rotate(_rotated_tile, false);
				_rotated_tile = tile_set_flip(_rotated_tile, false);
				_rotated_tile = tile_set_mirror(_rotated_tile, false);
				break;
			case 90:
				_rotated_tile = tile_set_rotate(_rotated_tile, true);
				_rotated_tile = tile_set_flip(_rotated_tile, true);
				_rotated_tile = tile_set_mirror(_rotated_tile, true);
				break;
			case 180:
				_rotated_tile = tile_set_rotate(_rotated_tile, false);
				_rotated_tile = tile_set_flip(_rotated_tile, true);
				_rotated_tile = tile_set_mirror(_rotated_tile, true);
				break;
			case 270:
				_rotated_tile = tile_set_rotate(_rotated_tile, true);
				_rotated_tile = tile_set_flip(_rotated_tile, false);
				_rotated_tile = tile_set_mirror(_rotated_tile, false);
				break;
		}
		
		_tile = _rotated_tile;
	}
	
	// Flip/Mirror tile
	if keyboard_check_pressed(ord("X")) {
		audio_play_sfx(sndPress, false, -5, 13);
		var _new_tile = _tile;
		
		image_xscale *= -1;
		_new_tile = tile_set_mirror(_new_tile, not tile_get_mirror(_tile));
		
		_tile = _new_tile;
	}
	
	selected_tile.tile_id = _tile;
}

set_object_rotation_and_scaling = function() {
	if is_undefined(selected_object) or current_layer != LEVEL_CURRENT_LAYER.OBJECTS then 
		return;
	
	if selected_object.has_tag("can_flip") {
		if keyboard_check_pressed(ord("X")) {
			if selected_object.has_tag("is_vertical") {
				image_yscale *= -1;
			} else {
				image_xscale *= -1;
			}
			
			audio_play_sfx(sndPress, false, -5, 13);
		}
	} else {
		image_xscale = 1;
	}
	
	if selected_object.has_tag("can_spin") {
		if keyboard_check_pressed(ord("Z")) {
			image_angle += 90;
			if image_angle >= 360 then image_angle = 0;
			audio_play_sfx(sndPress, false, -5, 13);
		}
	} else {
		image_angle = 0;
	}
}

get_lmobject_from_list = function(_object_index) {
	for(var t = 0; t < array_length(obj); t++) {
		var type = obj[t];
		
		for(var p = 0; p < array_length(type); p++) {
			if type[p].index == _object_index then return type[p];
		}
	}
}

get_tile_from_list = function(_tile_id) {
	for (var t = 0; t < array_length(tiles); t++) {
		var type = tiles[t];
		
		for(var p = 0; p < array_length(type); p++) {
			var _tile = type[p];
			if is_undefined(_tile) then continue;
			
			if _tile.original_tile_id == _tile_id then 
				return _tile;
		} 
	}
	return -1;
}

get_x_y_from_object_index = function(_object) {
	for (var yy = list_positions_length - 1; yy >= 0; yy--) {
		for (var xx = object_types_length - 1; xx >= 0; xx--) {
			var object_from_list = obj[xx, yy];
			
			if is_undefined(object_from_list) then continue;
			
			if (object_from_list.index == _object.index) {
				return [xx, yy];
			}
		}
	}
}

rotate_object_offset = function(_object_width, _object_height, _sprite_offset_x, _sprite_offset_y, _angle){
	var _half_width_object = (_object_width * tile_size) div 2;
	var _half_height_object = (_object_height * tile_size) div 2;
	
	_sprite_offset_x -= _half_width_object;
	_sprite_offset_y -= _half_height_object;
	
	var _dist = point_distance(0,0,_sprite_offset_x,_sprite_offset_y);
	var _dir = point_direction(0,0,_sprite_offset_x,_sprite_offset_y);
	
	_sprite_offset_x = lengthdir_x(_dist,_dir+_angle);
	_sprite_offset_y = lengthdir_y(_dist,_dir+_angle);
	
	_sprite_offset_x += _half_width_object;
	_sprite_offset_y += _half_height_object;
	
	return [_sprite_offset_x,_sprite_offset_y];
}

get_grid_object_hovering = function(_mouse_x, _mouse_y){
	for(var _x = 0; _x < room_tile_width; _x++){
		for(var _y = 0; _y < room_tile_height; _y++){
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			
			if is_struct(_object_grid) 
				and _top_left_x == _x
				and _top_left_y == _y
			{
				
				var _w = _object_grid.object_width;
				var _h = _object_grid.object_height;
				
				if point_in_rectangle(_mouse_x, _mouse_y, _x*tile_size,_y*tile_size, (_x+_w)*tile_size, (_y+_h)*tile_size) {
					return _object_grid;
				}
			}
		}	
	}
	return -1;
}

count_objects_in_grid = function(_object_index) {
	var counter = 0;
	
	for(var _x = 0; _x < room_tile_width; _x++){
		for(var _y = 0; _y < room_tile_height; _y++){
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			if _object_grid.object.index == _object_index {
				counter += 1;
			}
		}	
	}
	
	return counter;
}

place_object_in_object_grid = function(_top_left_x, _top_left_y, _object, _xscale = 1, _yscale = 1, _angle = 0){
	var _object_width = 1;
	var _object_height = 1;

	var _tiled_size = _object.get_size(tile_size);

	_object_width = _tiled_size[0];
	_object_height = _tiled_size[1];
	
	// Create object grid struct
	var _object_grid = new LMObjectGrid(
		_top_left_x,
		_top_left_y,
		_object,
		_object_width,
		_object_height,
		_xscale,
		_yscale,
		_angle
	);
	
	//make sure the object stays inside the grid
	_top_left_x = clamp(_top_left_x, 0, room_tile_width - _object_width);
	_top_left_y = clamp(_top_left_y, 0, room_tile_height - _object_height);
	
	for(var _x = _top_left_x; _x < _top_left_x + _object_width; _x++){
		for(var _y = _top_left_y; _y < _top_left_y + _object_height; _y++) {
			objects_grid[_x, _y] = _object_grid;
		}	
	}
}

remove_object_from_grid = function(_object_grid){
	var _top_left_x = _object_grid.top_left_x;
	var _top_left_y = _object_grid.top_left_y;
	
	var _object_width = _object_grid.object_width;
	var _object_height = _object_grid.object_height;
	
	for(var _x = _top_left_x; _x < _top_left_x + _object_width; _x++) {
		for(var _y = _top_left_y; _y < _top_left_y + _object_height; _y++) {
			objects_grid[_x, _y] = -1;
		}	
	}
}

check_for_objects_in_grid_position = function(_top_left_x, _top_left_y, _object) {
	if _object == undefined then return false;
	
	var _object_width = 1;
	var _object_height = 1;
	var _size = _object.get_size(tile_size);

	_object_width = _size[0];
	_object_height = _size[1];
	
	//make sure the object stays inside the grid
	_top_left_x = clamp(_top_left_x,0, room_tile_width - _object_width);
	_top_left_y = clamp(_top_left_y,0, room_tile_height - _object_height);
	
	for(var _x = _top_left_x; _x < _top_left_x+_object_width; _x++){
		for(var _y = _top_left_y; _y < _top_left_y+_object_height; _y++){
			var _object_grid = objects_grid[_x, _y];
			
			if is_struct(_object_grid) then return true;
		}	
	}
	
	return false;
}

remove_all_player_objects_from_grid = function() {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x, _y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			var _object_index = _object_grid.object;
			
			if is_struct(_object_grid)
				and _top_left_x == _x 
				and _top_left_y == _y 
				and _object_index.has_tag("is_player") 
			{
				remove_object_from_grid(_object_grid);
			}
		}
	}
}

remove_all_specific_objects_from_grid = function(_object_index) {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x, _y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			var _object = _object_grid.object;
			
			if is_struct(_object_grid)
				and _top_left_x == _x 
				and _top_left_y == _y 
				and _object.index == _object_index
			{
				remove_object_from_grid(_object_grid);
			}
		}
	}
}

remove_all_bird_objects_from_grid = function() {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x, _y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			var _object_index = _object_grid.object;
			
			if is_struct(_object_grid)
				and _top_left_x == _x 
				and _top_left_y == _y 
				and _object_index.has_tag("is_bird") 
			{
				remove_object_from_grid(_object_grid);
			}
		}
	}
}

remove_orb_from_grid = function() {
	for(var _x = 0; _x < room_tile_width; _x++){
		for(var _y = 0; _y < room_tile_height; _y++){
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			var _object_index = _object_grid.object;
			
			if is_struct(_object_grid)
				and _top_left_x == _x
				and _top_left_y == _y
				and (_object_grid.object.index == oMagicOrb 
					or _object_grid.object.index == oGrayOrb)
			{
				remove_object_from_grid(_object_grid);
			}
		}
	}
}

object_of_type_exists_in_editor = function(_object_index) {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			if is_struct(_object_grid)
				and _object_grid.object.index == _object_index then
				return true;
		}
	}
	
	return false;
}

start_level = function() {
    mode = LEVEL_EDITOR_MODE.TESTING;
	instance_destroy(oPause);
	audio_play_sfx(sndStarGame, false, -18.3, 1);
	
	// =========================
	// MUSIC SETTING
	// =========================
	switch (selected_style) {
		case LEVEL_STYLE.GRASS:	
			instance_create_layer(0, 0, "Instances", use_night_music ? o_grass_song_night : o_grass_song);
			break;
		case LEVEL_STYLE.CLOUDS:
			instance_create_layer(0, 0, "Instances", use_night_music ? o_cloud_song_night : o_cloud_song);
			break;
		case LEVEL_STYLE.FLOWERS:
			instance_create_layer(0, 0, "Instances", use_night_music ? o_flower_song_night : o_flower_song);
			break;
		case LEVEL_STYLE.SPACE:
			instance_create_layer(0, 0, "Instances", use_night_music ? o_space_song_night : o_space_song);
			break;
		case LEVEL_STYLE.DUNGEON:
			instance_create_layer(0, 0, "Instances", use_night_music ? o_dungeon_song_night : o_dungeon_song);
			break;
	}
	
	// =========================
	// ANIMATED TILES PLACEMENT
	// =========================
	//change_tiles_to_animated_sprites();
    with(oMakerEditorDraft) {
        set_in_room();
    }
	
	// =========================
	// OBJECTS PLACEMENT
	// =========================
	
	// This will be used to determine which objects will be
	// created first.
	var instance_queue = ds_priority_create();
	
	// Instantiate all objects on the level
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			
			if is_struct(_object_grid)
				and _top_left_x == _x 
				and _top_left_y == _y
			{
				var _object = _object_grid.object;
				var _xscale = _object_grid.xscale;
				var _yscale = _object_grid.yscale;
				var _angle = _object_grid.angle;
				
				var _sprite = object_get_sprite(_object.index);
				var _object_width = 1;
				var _object_height = 1;
				var _sprite_offset_x = sprite_get_xoffset(_sprite);
				var _sprite_offset_y = sprite_get_yoffset(_sprite);
				var _size = _object.get_size(tile_size);

				_object_width = _size[0];
				_object_height = _size[1];
				_sprite_offset_x = _size[2];
				_sprite_offset_y = _size[3];
			
				var _new_offset = rotate_object_offset(_object_width, _object_height, _sprite_offset_x, _sprite_offset_y, _angle);
				
				_sprite_offset_x = _new_offset[0];
				_sprite_offset_y = _new_offset[1];

				var _in_world_x = _x * tile_size + _sprite_offset_x;
				var _in_world_y = _y * tile_size + _sprite_offset_y;
				
				_in_world_x = round(_in_world_x);
				_in_world_y = round(_in_world_y);
				
				var _priority = 0;
				var _layer_name = "Player_Instances";
				
				switch(_object.index) {
					// THEY MUST BE THE LAST TO BE CREATED IN ROOM TO NOT BREAK THE STAR COUNTING.
					case oPlayer:
					case oPlayerDir:
					case oPlayerNeutral:
						_priority = 0;
						break;
						
					case oStar:
					case oStarColor:
					case oStarRunning:
					case oStarRunningColor:
					case oMagicOrb:
					case oGrayOrb:
					case oBird:
					case oSnail:
					case oSnailNight:
					case oSnailGray:
					case oBat:
					case oBatGiant:
					case oBatSuperGiant:
					case oBatVer:
					case oLady:
					case oLadyGiant:
					case oLadyGiant4:
					case oLadyVer:
					case oLadyGray:
						_priority = 1;
						break;
						
					default:
						_layer_name = "Gimmick_Instances";
						_priority = 10;
						break;
				}
				
				var _object_var_struct = {
					image_xscale: _xscale,
					image_yscale: _yscale,
					image_angle: _angle
				};

				ds_priority_add(
					instance_queue, 
					{
						x: _in_world_x,
						y: _in_world_y,
						layer: _layer_name,
						index: _object.index,
						var_struct: _object_var_struct
					},
					_priority
				);
			}
		}
	}
	
	repeat(ds_priority_size(instance_queue)) {
		var instance = ds_priority_delete_max(instance_queue);
		instance_create_layer(instance.x, instance.y, instance.layer, instance.index, instance.var_struct);
	}
	ds_priority_destroy(instance_queue);
	
	with(oLevelMaker) {
		scr_update_style();
	}

	// =========================
	// EFFECTS ENABLING
	// =========================
    var _fx_dust = layer_get_id("FX_Dust");
    var _fx_background_fog = layer_get_id("FX_Background_Fog");

    layer_set_visible(_fx_dust, true);

    if selected_style == LEVEL_STYLE.DUNGEON then
        layer_set_visible(_fx_background_fog, true);
	
    level_maker_change_fx();

	with(oBrokenStone) {
		brokenright = instance_place(x+1,y,oBrokenStone)
		brokenleft = instance_place(x-1,y,oBrokenStone)
		brokenup = instance_place(x,y-1,oBrokenStone)
		brokendown = instance_place(x,y+1,oBrokenStone)
	}
}

delete_all_objects_from_level = function() {
	for (var yy = list_positions_length - 1; yy>=0; yy-=1) {
		for (var xx = object_types_length - 1; xx>=0; xx-=1) {
			var object = obj[xx, yy];
			
			if is_undefined(obj[xx, yy]) then continue;
			instance_destroy(object.index, false);
		}
	}
}

end_level_and_return_to_editor = function() {
	//destroy the "song"
    
	instance_destroy(o_music);
	audio_stop_all()
	
	delete_all_objects_from_level();
    with(oMakerEditorDraft) {
        remove_from_room();
    }

    mode = LEVEL_EDITOR_MODE.EDITING;
	instance_create_layer(-16, -16, layer, oPause);
	
	// Reset day/night state
	if instance_exists(oCamera) then
		oCamera.night = false;
	
	// Destroy gimmicks that would persist on level editor after playtest
	instance_destroy(oNeutralFlag);
	instance_destroy(oKeyFollow, false);
	instance_destroy(oKeyFollow2, false);
	instance_destroy(oKeyFollow3, false);
	
    // Disable layer effects
    var _fx_dust = layer_get_id("FX_Dust");
    var _fx_background_fog = layer_get_id("FX_Background_Fog");

    layer_set_visible(_fx_dust, false);
    layer_set_visible(_fx_background_fog, false);

    level_maker_change_fx();
    audio_play_sfx(snd_bump, false, 1, 1);
	just_entered_level_editor = true;
}

//CAMERA CODE

oCamera.fancyeffects = true;

camera_current_interpolation = 0;

global.level_maker_mouse_x = mouse_x;
global.level_maker_mouse_y = mouse_y;

just_entered_level_editor = false;

instance_create_layer(x,y,layer,oPause);

//----------------------
// DEFAULT LEVEL

// floor
var fi = 0;
repeat(6) {
	place_object_in_object_grid(14 + 2 * fi, 14, get_lmobject_from_list(oSolid));
	fi++;
}

// player
place_object_in_object_grid(16, 12, get_lmobject_from_list(oPlayer));

// star
place_object_in_object_grid(22, 12, get_lmobject_from_list(oStar));

update_selected_object();
update_selected_tile();