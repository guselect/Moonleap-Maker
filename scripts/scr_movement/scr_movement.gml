#macro MOVING_PLATFORM_OBJECTS [oSnail, oSnailNight, oSnailGray, oLady, oLadyVer, oBat, oBatVer]

/// @desc This function initializes variables and methods related to object's movement and it must be called in the object's Create event.
function init_movement_variables() {
  hsp = 0;
  vsp = 0;
  hsp_final = 0;
  vsp_final = 0;
  _hsp_rest = 0;
  _vsp_rest = 0;
  
  _moving_platform = noone;
  
  /// @desc This function uses the current speeds (`hsp` and `vsp`) to calculate the final speeds (`hsp_final` and `vsp_final`), making them integer numbers and storing the decimal rest to sum the final speeds on the next calculation frame.
  __calc_subpixel_movement = function() {
    _hsp_rest += hsp;
   	_vsp_rest += vsp;
   	hsp_final = floor(_hsp_rest);
   	vsp_final = floor(_vsp_rest);
   	_hsp_rest -= hsp_final;
   	_vsp_rest -= vsp_final;
  };
  
  /// @desc This function applies movement when moving up or down on slopes.
  __apply_slopes_movement = function() {
    var _place_meeting = can_collision_wrap() ? place_meeting_wrap_room : place_meeting;
    
    if _place_meeting(x + sign(hsp), y, oSolid)
    and not _place_meeting(x + sign(hsp), y - 1, oSolid) {
      y -= 1;
    }

    if vsp >= 0
    and not _place_meeting(x + sign(hsp), y, oSolid)
    and not _place_meeting(x + sign(hsp), y + 1, oSolid)
    and _place_meeting(x + sign(hsp), y + 2, oSolid) {
      y += 1;
    }
  };
  
  __find_platform_below = function() {
    var _platforms_below = can_collision_wrap() ?
      instance_place_array_wrap_room(x, y + 1, MOVING_PLATFORM_OBJECTS)
      : instance_place_array(x, y + 1, MOVING_PLATFORM_OBJECTS);
    
    if array_length(_platforms_below) == 0 {
      _moving_platform = noone;
      return
    }
    
    _moving_platform = _platforms_below[0];
  };
  
  /// @desc This function applies movement and collision above the moving plataform.
  __apply_movement_above_moving_platform = function() {
    if _moving_platform == noone {
      return;
    }
    
    repeat abs(_moving_platform.vsp_final) {
      var _step = sign(_moving_platform.vsp_final);
      
      if has_collided(0, _step) {
        break;
      }
      y += _step;
    }

    repeat abs(_moving_platform.hsp_final) {
      var _step = sign(_moving_platform.hsp_final);
      
      if has_collided(_step, 0) {
        break;
      }
      x += _step;
    }
  }
  
  /// @desc This function makes the object get pushed by moving platforms when they are coming from sides.
  __get_pushed_by_moving_platform_sides = function() {
    var _platform_side_left = can_collision_wrap() ?
      instance_place_array_wrap_room(x - 1, y, MOVING_PLATFORM_OBJECTS)
      : instance_place_array(x - 1, y, MOVING_PLATFORM_OBJECTS, true);
    var _platforms_side_right = can_collision_wrap() ?
      instance_place_array_wrap_room(x + 1, y, MOVING_PLATFORM_OBJECTS)
      : instance_place_array(x + 1, y, MOVING_PLATFORM_OBJECTS, true);
    var _platforms_side = [];
    
    array_foreach(_platform_side_left, method({ side: _platforms_side }, function(_platforms) {
      array_push(side, _platforms);
    }));
    array_foreach(_platforms_side_right, method({ side: _platforms_side }, function(_platforms) {
      array_push(side, _platforms);
    }));
    
    if array_length(_platforms_side) == 0 {
      return;
    }

    var _platform = _platforms_side[0];
    var _step = sign(_platform.hsp_final);
    
    repeat abs(_platform.hsp_final) {
      var _place_met = can_collision_wrap()
        ? place_meeting_wrap_room(x + _step, y, _platforms_side)
        : place_meeting(x + _step, y, _platforms_side);
      
      if _place_met {
        hsp = 0;
        hsp_final = 0;
        break;
      }
      
      x += _step;
    }
  };
  
  /// @desc Moves the object by its final speeds and stops moving when colliding with wall objects.
  /// @param {bool} enable_slopes_movement When `true`, when moving horizontally, it will detect for slopes to move on them. It's not suitable for flying objects. Default: `true`
  /// @param {bool} avoid_other_moving_platforms  When `true`, this object will not be moved by other moving platforms when it's above them. It's suitable for moving platforms. Default: `false`.
  /// @param {Array<GM.Object>} exclude_collision_objects An array of objects and/or instances to ignore collision. Default: empty array.
  apply_movement_collision = function(enable_slopes_movement = true, avoid_other_moving_platforms = false, exclude_collision_objects = []) {
    __calc_subpixel_movement();
    
    if not avoid_other_moving_platforms {
      __apply_movement_above_moving_platform();
      __get_pushed_by_moving_platform_sides();
    }
    
    repeat(abs(vsp_final)) {
    	if has_collided(0, sign(vsp_final), true, [], exclude_collision_objects) {
    		vsp = 0;
        vsp_final = 0;
        break;
    	}
    	
    	y += sign(vsp_final);
    }
    
    repeat(abs(hsp_final)) {
      if enable_slopes_movement {
        __apply_slopes_movement();
      }
    	
    	if has_collided(sign(hsp_final), 0, true, [], exclude_collision_objects) {
    		hsp = 0;
        hsp_final = 0;
    		break;
    	}
    	
    	x += sign(hsp_final);
    }
    
    if not avoid_other_moving_platforms {
      __find_platform_below();
    }
  }
}