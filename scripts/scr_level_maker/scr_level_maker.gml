enum LEVEL_CURSOR_TYPE { 
	NOTHING,
	CURSOR,
	FINGER,
	ERASER
}

enum LEVEL_STYLE {
	GRASS,
	CLOUDS,
	FLOWERS,
	SPACE,
	DUNGEON,
	LENGTH
}

enum SPRITE_ORIGIN {
	TOP_LEFT,
	CENTER,
	BOTTOM,
	OFFSET5
}

/// @description A "Level Maker Object" constructor. Use this as base to create
/// an object for the level editor.
/// @param {Asset.GMObject} _object_index The matching object index of the level object.
/// @param {real} _object_size_x The horizontal size this object will occupy on the level grid.
/// @param {real} _object_size_y The vertical size this object will occupy on the level grid.
/// @param {real} _origin_type The origin type to position the object sprite on level grid.
/// Use one of the SPRITE_ORIGIN enumerator values to set it.
function LMObject(_object_index, _object_size_x, _object_size_y, _origin_type = SPRITE_ORIGIN.TOP_LEFT) constructor {
	label = "";
	index = _object_index;
	size_x = _object_size_x;
	size_y = _object_size_y;
	origin_type = _origin_type;
	tags = [];
	object_config = undefined;
	
	preview_image_index_vertical = undefined;
	
	sprite_button_sprite_index = undefined;
	sprite_button_image_index = 0;
	sprite_button_x_offset = 0;
	sprite_button_y_offset = 0;
	sprite_button_part_left = 0;
	sprite_button_part_top = 0;
	sprite_button_part_width = 16;
	sprite_button_part_height = 16;
	
	set_preview_index_vertical = function(_image_index_flipped = 0) {
		preview_image_index_vertical = _image_index_flipped;
		return self;
	}
	
	set_sprite_button_part = function(
		new_sprite_index,
		new_image_index,
		left_position,
		top_position,
		x_offset, 
		y_offset,
		width = undefined,
		height = undefined
	) {
		sprite_button_sprite_index = new_sprite_index;
		sprite_button_image_index = new_image_index;
		sprite_button_part_left = left_position;
		sprite_button_part_top = top_position;
		sprite_button_x_offset = x_offset;
		sprite_button_y_offset = y_offset;
		sprite_button_part_width = is_undefined(width) ? sprite_button_part_width : width;
		sprite_button_part_height = is_undefined(height) ? sprite_button_part_height : height;
		return self;
	}
	
	set_object_config = function(_object_config) {
		if not is_struct(_object_config) then
			throw "Object config must be a struct of object variables names as keys.";
		
		object_config = _object_config;
		return self;
	}
	
	draw_sprite_button_part = function(_x, _y) {
		var sprite = sprite_button_sprite_index;
		var sprite_nineslice = sprite_get_nineslice(sprite);
		var prev_nineslice_enabled = sprite_nineslice.enabled;
		
		sprite_nineslice.enabled = false;
		draw_sprite_part(sprite, sprite_button_image_index, sprite_button_part_left, sprite_button_part_top, sprite_button_part_width, sprite_button_part_height, _x + sprite_button_x_offset, _y + sprite_button_y_offset);
		sprite_nineslice.enabled = prev_nineslice_enabled;
	}
	
	add_tag = function() {
		var i = 0;
		
		repeat(argument_count) {
			var _tag = argument[i]
			
			if typeof(_tag) != "string" then throw ("A tag must be a string.");
			array_push(tags, _tag);
			i++;
		}
		
		return self;
	}
	
	has_tag = function(_tag) {
		return array_find_index(tags, _tag) == -1 ? false : true;
	}
	
	/// @desc Gets the x and y position of the object's sprite origin depending of its origin type.
	/// @returns {Array<real>} Array of x and y position of the sprite origin respectively.
	get_sprite_offset_typed = function(_tile_size, _object_tile_width, _object_tile_height) {
		var _sprite = object_get_sprite(index);
		var _offx = sprite_get_xoffset(_sprite);
		var _offy = sprite_get_yoffset(_sprite);
		var _w = sprite_get_width(_sprite);
		var _h = sprite_get_height(_sprite);
		
		switch(origin_type){
			case SPRITE_ORIGIN.OFFSET5:
				return [
					_offx - 8,
					_offy - 8
				];
			case SPRITE_ORIGIN.TOP_LEFT:
				return [
					_offx,
					_offy
				];
			case SPRITE_ORIGIN.BOTTOM:
				return [
					_offx - _w / 2 + _object_tile_width * _tile_size / 2,
					_offy - _h + _object_tile_height * _tile_size,
				];
			case SPRITE_ORIGIN.CENTER:
				return [
					_offx - _w / 2 + _object_tile_width * _tile_size / 2,
					_offy - _h / 2 + _object_tile_height * _tile_size / 2
				];
		}
	}
	
	get_size = function(_tile_size = 8) {
		var _tiled_width = size_x / _tile_size;
		var _tiled_height = size_y / _tile_size;
		
		var _offset = get_sprite_offset_typed(_tile_size, _tiled_width, _tiled_height);
		
		return [_tiled_width, _tiled_height, _offset[0], _offset[1]];
	}
	
	return self;
}

/// @param {real} _top_left_x
/// @param {real} _top_left_y
/// @param {Asset.GMObject} _object
/// @param {real} _object_width
/// @param {real} _object_height
/// @param {real} _xscale
/// @param {real} _yscale
/// @param {real} _angle
function LMObjectGrid(_top_left_x, _top_left_y, _object, _object_width, _object_height, _xscale, _yscale, _angle) constructor {
	top_left_x = _top_left_x;
	top_left_y = _top_left_y;
	object = _object;
	object_width = _object_width;
	object_height = _object_height;
	xscale = _xscale;
	yscale = _yscale;
	angle = _angle;
}