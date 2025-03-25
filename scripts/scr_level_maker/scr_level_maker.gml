enum LEVEL_CURSOR_TYPE { 
	NOTHING,
	CURSOR,
	FINGER,
	ERASER
}

enum SPRITE_POSITIONING_TYPE {
	TOP_LEFT,
	CENTER,
	BOTTOM,
	OFFSET5,
}

/// @description A "Level Maker Object" constructor. Use this as base to create
/// an object for the level editor.
/// @param {string} _name The object name for the level object that will display on screen.
/// @param {Asset.GMObject} _object The matching object index of the level object.
/// @param {real} _size_x The horizontal size this object will occupy on the level grid.
/// @param {real} _size_y The vertical size this object will occupy on the level grid.
/// @param {real} _origin_type The origin type to position the object sprite on level grid.
/// Use one of the SPRITE_POSITIONING_TYPE enumerator values to set it.
function LMObject(_name, _object, _size_x, _size_y, _origin_type = SPRITE_POSITIONING_TYPE.TOP_LEFT) constructor {
	name = _name;
	object = _object;
	size_x = _size_x;
	size_y = _size_y;
	origin_type = _origin_type;
	
	/// @desc Gets the x and y position of the object's sprite origin depending of its origin type.
	/// @returns {Array<real>} Array of x and y position of the sprite origin respectively.
	get_sprite_offset_typed = function(_tile_size, _object_tile_width, _object_tile_height) {
		var _sprite = object_get_sprite(object);
		var _offx = sprite_get_xoffset(_sprite);
		var _offy = sprite_get_yoffset(_sprite);
		var _w = sprite_get_width(_sprite);
		var _h = sprite_get_height(_sprite);
		
		switch(origin_type){
			case SPRITE_POSITIONING_TYPE.OFFSET5:
				return [
					_offx - 8,
					_offy - 8
				];
			case SPRITE_POSITIONING_TYPE.TOP_LEFT:
				return [
					_offx,
					_offy
				];
			case SPRITE_POSITIONING_TYPE.BOTTOM:
				return [
					_offx - _w / 2 + _object_tile_width * _tile_size / 2,
					_offy - _h + _object_tile_height * _tile_size,
				];
			case SPRITE_POSITIONING_TYPE.CENTER:
				return [
					_offx - _w / 2 + _object_tile_width * _tile_size / 2,
					_offy - _h / 2 + _object_tile_height * _tile_size / 2
				];
		}
	}
	
	get_size = function(_tile_size) {
		var _tiled_width = size_x / _tile_size;
		var _tiled_height = size_y / _tile_size;
		
		var _offset = get_sprite_offset_typed(_tile_size, _tiled_width, _tiled_height);
		
		return [_tiled_width, _tiled_height, _offset[0], _offset[1]];
	}
}