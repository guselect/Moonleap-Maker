#macro SPRITE_SLICES_OTHER_SOLIDS [object_index, oSolid]

/// @desc This constructor defines a struct of the parts of a sprite to be drawn by a `SpriteSlices` system struct.
/// @param {real} _left The left position of the area of the sprite to be drawn.
/// @param {real} _top The top position of the area of the sprite to be drawn.
/// @param {real} _width The width of the area of the sprite to be drawn.
/// @param {real} _height The height of the area of the sprite to be drawn.
function SpriteSliceBox(_left = 0, _top = 0, _width = 0, _height = 0) constructor {
  left = _left;
  top = _top;
  width = _width;
  height = _height;
}


/// @desc This constructor contains the sprite slices system that draws sprites parts hiding sides that are colliding with other instances of the same object.
/// @param {Asset.GMObject|Id.Instance} _obj The object to be drawn.
function SpriteSlices(_obj) constructor {
  obj = _obj;
  neighbor_check_distance = 1;
  update_neighbors_once = false;
  slice_boxes = {
    center: new SpriteSliceBox(),
    left: new SpriteSliceBox(),
    right: new SpriteSliceBox(),
    top: new SpriteSliceBox(),
    bottom: new SpriteSliceBox(),
  }
  
  _neighbors = {
    left: false,
    right: false,
    top: false,
    bottom: false
  };
  _is_neighbors_check_once_done = false;
  
  /// @desc This function finds and registers the occurance of other instances of the same object neighbours to the current object at the four sides (left, right, top and bottom).
  update_neighbors = function() {
    if _is_neighbors_check_once_done {
      return;
    }
    
    var _dist = neighbor_check_distance;
    var _angle = angle_normalize(obj.image_angle);
    
    switch (_angle) {
      // Facing up
      case 0:
        with(obj) {
          other._neighbors.left = place_meeting(x - _dist, y, SPRITE_SLICES_OTHER_SOLIDS);
          other._neighbors.right = place_meeting(x + _dist, y, SPRITE_SLICES_OTHER_SOLIDS);
          other._neighbors.top = place_meeting(x, y - _dist, SPRITE_SLICES_OTHER_SOLIDS);
          other._neighbors.bottom = place_meeting(x, y + _dist, SPRITE_SLICES_OTHER_SOLIDS);
        }
      break;
      
      // Facing left
      case 90:
        with(obj) {
          other._neighbors.left = place_meeting(x, y + _dist, SPRITE_SLICES_OTHER_SOLIDS);
          other._neighbors.right = place_meeting(x, y - _dist, SPRITE_SLICES_OTHER_SOLIDS);
          other._neighbors.top = place_meeting(x - _dist, y, SPRITE_SLICES_OTHER_SOLIDS);
          other._neighbors.bottom = place_meeting(x + _dist, y, SPRITE_SLICES_OTHER_SOLIDS);
        }
      break;
      
      // Facing down
      case 180:
        with(obj) {
          other._neighbors.left = place_meeting(x + _dist, y, SPRITE_SLICES_OTHER_SOLIDS);
          other._neighbors.right = place_meeting(x - _dist, y, SPRITE_SLICES_OTHER_SOLIDS);
          other._neighbors.top = place_meeting(x, y + _dist, SPRITE_SLICES_OTHER_SOLIDS);
          other._neighbors.bottom = place_meeting(x, y - _dist, SPRITE_SLICES_OTHER_SOLIDS);
        }
      break;
      
      // Facing right
      case 270:
        with(obj) {
          other._neighbors.left = place_meeting(x, y - _dist, SPRITE_SLICES_OTHER_SOLIDS);
          other._neighbors.right = place_meeting(x, y + _dist, SPRITE_SLICES_OTHER_SOLIDS);
          other._neighbors.top = place_meeting(x + _dist, y, SPRITE_SLICES_OTHER_SOLIDS);
          other._neighbors.bottom = place_meeting(x - _dist, y, SPRITE_SLICES_OTHER_SOLIDS);
        }
      break;
    }
    
    if update_neighbors_once {
      _is_neighbors_check_once_done = true;
    }
  };
  
  /// @desc This function draws the sprite based on the neighbours found next each other. If there are a neighbor in the side of this object, part of it won't be drawn.
  /// @param {Asset.GMSprite} sprite The sprite to be drawn. Based on `slice_boxes` configuration, five parts of it will be drawn (center, left, right, top and bottom).
  /// @param {real} frame The sub-index of the `sprite` to be drawn.
  /// @param {real} xx The horizontal position of the sprite to be drawn.
  /// @param {real} yy The vertical position of the sprite to be drawn.
  /// @param {real} xscale The horizontal scale of the sprite to be drawn.
  /// @param {real} yscale The vertical scale of the sprite to be drawn.
  /// @param {real} blend The color blend of the sprite to be drawn.
  /// @param {real} alpha The alpha of the sprite to be drawn.
  draw_sprite_slices = function(sprite, frame, xx, yy, xscale, yscale, angle, blend, alpha) {
    var _nineslice = sprite_get_nineslice(sprite),
        _was_nineslice_enabled = false;
    
    if _nineslice.enabled {
      _nineslice.enabled = false;
      _was_nineslice_enabled = true;
    }
    
    struct_foreach(slice_boxes, method({
      _obj: obj,
      _boxes: slice_boxes,
      __neighbors: _neighbors,
      _sprite: sprite,
      _frame: frame,
      _xx: xx,
      _yy: yy,
      _xscale: xscale,
      _yscale: yscale,
      _angle: angle,
      _blend: blend,
      _alpha: alpha
    }, function(_side_name, _value) {
      var _side = _boxes[$ _side_name],
          _is_center_part = _side_name == "center";
      
      if _is_center_part
      or (struct_exists(__neighbors, _side_name) and not __neighbors[$ _side_name]) {
        var _xoffset = _side.left - sprite_get_xoffset(_sprite),
            _yoffset = _side.top - sprite_get_yoffset(_sprite),
            _old_matrix = matrix_get(matrix_world),
            _sprite_matrix = matrix_build(_xx, _yy, 0, 0, 0, _angle, _xscale, _yscale, 1);
        
        matrix_set(matrix_world, _sprite_matrix);
        
        draw_sprite_part_ext(
          _sprite,
          _frame,
          _side.left,
          _side.top,
          _side.width,
          _side.height,
          _xoffset,
          _yoffset,
          1,
          1,
          _blend,
          _alpha
        );
        
        matrix_set(matrix_world, _old_matrix);
      }
    }));
    
    if _was_nineslice_enabled {
      _nineslice.enabled = true;
      sprite_set_nineslice(sprite, _nineslice);
    }
  };
}