enum LEVEL_MAKER_OBJECT_SPRITE_ORIGIN { TOP_LEFT, CENTER, BOTTOM, OFFSET5 }

/// @description A "Level Maker Object" constructor. Use this as base to create
/// an object for the level editor.
/// @param {Asset.GMObject} _object_index The matching object index of the level object.
function LMObject(_object_index) constructor {
	label = "";
	index = _object_index;
	size_x = 16;
	size_y = 16;
	origin_type = LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.TOP_LEFT;
	tags = [];
  colorblind_icon_frame = -1;
	
	button_sprite_sprite_index = undefined;
	button_sprite_image_index = 0;
	button_sprite_x_offset = 0;
	button_sprite_y_offset = 0;
	button_sprite_part_left = 0;
	button_sprite_part_top = 0;
	button_sprite_part_width = 16;
	button_sprite_part_height = 16;
  
  on_begin_draw_button_sprite = function(_sprite, _frame) {};
  on_end_draw_button_sprite = function(_sprite, _frame) {};
  
  on_begin_draw_preview_sprite = function(_xscale = 1, _yscale = 1, _angle = 0) {};
  on_end_draw_preview_sprite = function() {};

  /// @desc Sets the size of the object in the level editor.
  /// @param {real} _width The object width in pixels in the editor.
  /// @param {real} _height The object height in pixels in the editor.
  static set_size = function(_width, _height) {
    size_x = _width;
    size_y = _height;
    return self;
  };
  
  /// @desc Sets the colorblind icon frame to the object.
  /// @param {real} _frame The colorblind icon frame number. Use 0 or 1 for the icon. Use -1 to disable it.
  static set_colorblind_icon_frame = function(_frame) {
    colorblind_icon_frame = _frame;
    
    return self;
  };
  
  /// @param {real} _origin The sprite origin to be relative when positioning the object in the level editor.
  /// Use a `LEVEL_MAKER_OBJECT_SPRITE_ORIGIN` enumerator value.
  static set_sprite_origin = function(_origin) {
    if is_nan(_origin) {
      throw "The object sprite origin must be a number or a value from LEVEL_MAKER_OBJECT_SPRITE_ORIGIN enumerator."
      return;
    }
    
    origin_type = _origin;
    return self;
  };
	
  /// @desc Configs the part of the object sprite that is displayed in a Level Maker button.
  /// @param {Asset.GMSprite} _sprite The object's sprite index.
  /// @param {real} _frame The object' sprite frame.
  /// @param {real} _part_left The left point of the object's sprite.
  /// @param {real} _part_top The top point of the object's sprite.
  /// @param {real} _x_offset The horizontal offset of the object's sprite position.
  /// @param {real} _y_offset The vertical offset of the object's sprite position.
  /// @param {real} _part_width The right point of the object's sprite.
  /// @param {real} _part_height The bottom point of the object's sprite.
	static set_button_sprite_draw_config = function(
		_sprite,
		_frame,
		_part_left,
		_part_top,
		_x_offset, 
		_y_offset,
		_part_width = undefined,
		_part_height = undefined
	) {
		button_sprite_sprite_index = _sprite;
		button_sprite_image_index = _frame;
		button_sprite_part_left = _part_left;
		button_sprite_part_top = _part_top;
		button_sprite_x_offset = _x_offset;
		button_sprite_y_offset = _y_offset;
		button_sprite_part_width = is_undefined(_part_width) ? button_sprite_part_width : _part_width;
		button_sprite_part_height = is_undefined(_part_height) ? button_sprite_part_width : _part_height;
    
		return self;
	}
	
	static draw_button_sprite = function(_x, _y) {
    if is_method(on_begin_draw_button_sprite) {
      on_begin_draw_button_sprite(button_sprite_sprite_index, button_sprite_image_index);
    }
    
		var _sprite = button_sprite_sprite_index,
		    _sprite_nineslice = sprite_get_nineslice(_sprite),
		    _prev_nineslice_enabled = _sprite_nineslice.enabled;
		
		_sprite_nineslice.enabled = false;
		draw_sprite_part(
      _sprite,
      button_sprite_image_index,
      button_sprite_part_left,
      button_sprite_part_top,
      button_sprite_part_width,
      button_sprite_part_height,
      _x + button_sprite_x_offset,
      _y + button_sprite_y_offset
    );
		_sprite_nineslice.enabled = _prev_nineslice_enabled;
    
    if is_method(on_end_draw_button_sprite) {
      on_end_draw_button_sprite(button_sprite_sprite_index, button_sprite_image_index);
    }
	};
  
  static draw_cursor_preview_sprite = function(_x, _y, _xscale, _yscale, _angle, _blend, _alpha) {
    var _sprite = object_get_sprite(index),
        _frame = 0;
    
    if is_method(on_begin_draw_preview_sprite) {
      var _new_config = on_begin_draw_preview_sprite(_xscale, _yscale, _angle);
      
      if not is_undefined(_new_config) {
        if struct_exists(_new_config, "sprite") then _sprite = _new_config.sprite;
        if struct_exists(_new_config, "frame")  then _frame = _new_config.frame;
        if struct_exists(_new_config, "xscale") then _xscale = _new_config.xscale;
        if struct_exists(_new_config, "yscale") then _yscale = _new_config.yscale;
        if struct_exists(_new_config, "angle")  then _angle = _new_config.angle;
      }
    }
    
    draw_sprite_ext(_sprite, _frame, _x, _y, _xscale, _yscale, _angle, _blend, _alpha);
    
    if is_method(on_end_draw_preview_sprite) {
      on_end_draw_preview_sprite();
    }
  };
  
  static draw_preview_sprite = function(_x, _y, _xscale, _yscale, _angle) {
    var _sprite = object_get_sprite(index),
        _object_width = 1,
        _object_height = 1,
        _sprite_offset_x = sprite_get_xoffset(_sprite),
        _sprite_offset_y = sprite_get_yoffset(_sprite),
        _size = get_tiled_size_and_sprite_offset();
    
    _object_width = _size.tiled_width;
    _object_height = _size.tiled_height;
    _sprite_offset_x = _size.sprite_x_offset;
    _sprite_offset_y = _size.sprite_y_offset;
    
    var _new_offset = rotate_object_offset(
      _object_width,
      _object_height,
      _sprite_offset_x,
      _sprite_offset_y,
      _angle
    );
    
    _sprite_offset_x = _new_offset.sprite_x_offset;
    _sprite_offset_y = _new_offset.sprite_y_offset;
    
    var _frame = 0,
        _blend = c_white,
        _alpha = 1,
        _final_xscale = _xscale,
        _final_yscale = _yscale;

    if is_method(on_begin_draw_preview_sprite) {
      var _new_config = on_begin_draw_preview_sprite(_xscale, _yscale, _angle);
      
      if not is_undefined(_new_config) {
        if struct_exists(_new_config, "sprite") then _sprite = _new_config.sprite;
        if struct_exists(_new_config, "frame")  then _frame = _new_config.frame;
        if struct_exists(_new_config, "xscale") then _xscale = _new_config.xscale;
        if struct_exists(_new_config, "yscale") then _yscale = _new_config.yscale;
        if struct_exists(_new_config, "angle")  then _angle = _new_config.angle;
      }
    }
    
    draw_sprite_ext(
      _sprite,
      _frame,
      _x + _sprite_offset_x,
      _y + _sprite_offset_y,
      _xscale,
      _yscale,
      _angle,
      _blend,
      _alpha
    );
    
    if is_method(on_end_draw_preview_sprite) {
      on_end_draw_preview_sprite();
    }
  };
	
  /// @desc Adds a tag to the object.
  /// @param {string} tags One or more tags to add to the object.
	static add_tag = function() {
    if argument_count <= 0 {
      throw "You forgot to add tags to the object here. Also, make sure that they are strings.";
    }
    
    for (var i = 0; i < argument_count; i++) {
      var _tag = argument[i];
			
			if typeof(_tag) != "string" {
        throw "A tag must be a string.";
      }
			array_push(tags, _tag);
    }
		
		return self;
	};
	
  /// @desc Checks whether the object has a defined tag in it.
  /// @param {String} _tag The tag to be checked
	static has_tag = function(_tag) {
		return array_find_index_of_value(tags, _tag) == -1 ? false : true;
	};
	
	/// @desc Gets the `x` and `y` position of the object's sprite origin depending of its origin type.
	/// @returns {Array<real>} Array of `x` and `y` position of the sprite origin respectively.
	static get_sprite_offset_typed = function(_tile_size, _object_tile_width, _object_tile_height) {
		var _sprite = object_get_sprite(index);
		var _offx = sprite_get_xoffset(_sprite);
		var _offy = sprite_get_yoffset(_sprite);
		var _w = sprite_get_width(_sprite);
		var _h = sprite_get_height(_sprite);
		
		switch(origin_type) {
			case LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.OFFSET5:
				return [
					_offx - 8,
					_offy - 8
				];
			case LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.TOP_LEFT:
				return [
					_offx,
					_offy
				];
			case LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.BOTTOM:
				return [
					_offx - _w / 2 + _object_tile_width * _tile_size / 2,
					_offy - _h + _object_tile_height * _tile_size,
				];
			case LEVEL_MAKER_OBJECT_SPRITE_ORIGIN.CENTER:
				return [
					_offx - _w / 2 + _object_tile_width * _tile_size / 2,
					_offy - _h / 2 + _object_tile_height * _tile_size / 2
				];
		}
	};
  
  static rotate_object_offset = function(_object_width, _object_height, _sprite_offset_x, _sprite_offset_y, _angle){
    var _half_width_object = (_object_width * LEVEL_MAKER_GRID_OBJECTS_TILE_SIZE) div 2;
    var _half_height_object = (_object_height * LEVEL_MAKER_GRID_OBJECTS_TILE_SIZE) div 2;
    
    _sprite_offset_x -= _half_width_object;
    _sprite_offset_y -= _half_height_object;
    
    var _dist = point_distance(0, 0, _sprite_offset_x, _sprite_offset_y);
    var _dir = point_direction(0, 0, _sprite_offset_x, _sprite_offset_y);
    
    _sprite_offset_x = lengthdir_x(_dist, _dir + _angle);
    _sprite_offset_y = lengthdir_y(_dist, _dir + _angle);
    
    _sprite_offset_x += _half_width_object;
    _sprite_offset_y += _half_height_object;
    
    return {
      sprite_x_offset: _sprite_offset_x,
      sprite_y_offset: _sprite_offset_y
    };
  }
	
	static get_tiled_size_and_sprite_offset = function() {
		var _tiled_width = size_x / LEVEL_MAKER_GRID_OBJECTS_TILE_SIZE;
		var _tiled_height = size_y / LEVEL_MAKER_GRID_OBJECTS_TILE_SIZE;
		
		var _offset = get_sprite_offset_typed(
      LEVEL_MAKER_GRID_OBJECTS_TILE_SIZE,
      _tiled_width,
      _tiled_height
    );
		
		return {
      tiled_width: _tiled_width,
      tiled_height: _tiled_height,
      sprite_x_offset: _offset[0],
      sprite_y_offset: _offset[1]
    };
	};
	
	return self;
}

/// @desc Object data used to compose the main object grid data.
/// @param {real} _top_left_x The left origin of the object
/// @param {real} _top_left_y The top origin of the object
/// @param {Asset.GMObject} _object The object index
/// @param {real} _object_width The object width
/// @param {real} _object_height The object height
/// @param {real} _xscale The object horizontal scale
/// @param {real} _yscale The object vertical scale
/// @param {real} _angle The object angle (0 - 359)
function LMObjectGrid(
  _top_left_x,
  _top_left_y,
  _object,
  _object_width,
  _object_height,
  _xscale,
  _yscale,
  _angle
) constructor {
	top_left_x = _top_left_x;
	top_left_y = _top_left_y;
	object = _object;
	object_width = _object_width;
	object_height = _object_height;
	xscale = _xscale;
	yscale = _yscale;
	angle = _angle;
}

