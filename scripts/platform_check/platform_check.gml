/// @description  platform_check();
function platform_check() {
	if (vsp <= 0) {
	    platform_target = 0;
		return false
	}
	
	var collision = instance_place(x, y + sign(vsp), oSolid); 

	if (collision) {
	    if (vsp >= 0) {
	        platform_target = collision;
	    } else {
	        // Platform above
	        vsp = 0;
	    }
	    return true;
	}

	if (instance_exists(platform_target)) {
	    if (platform_target) {
	        if (place_meeting(x, y + 1, platform_target) && !place_meeting(x, y, platform_target)) {
	            //Platform below
	            vsp = 0;
	            return true;
	        } else
	            platform_target = 0;
	    }
	} else
	    platform_target = 0;
    
	if (vsp > 0) {
	    with (oPlayer) {
	        if (place_meeting(x, y - 1, other) && !place_meeting(x, y, other)) {
	            vsp = 0;
	        }
	    }
    
	    with (oPlatGhost) {
			//  && !place_meeting(x, y, other)
	        if (place_meeting(x, y - 1, other) && other.bbox_bottom <= bbox_top) {
	            // Land
	            vsp = 0;
	            other.platform_target = id;
	            return true;
	        }
	    }
	}

	platform_target = 0;
	return false;
}

/// @param {real} xx The horizontal position.
/// @param {real} yy The vertical position.
/// @param {bool} is_position_relative If true, the xx and yy positions are relative to the object position.
/// If false, they are relative to the room position. Default: true
function has_collided(xx, yy, is_position_relative = true) {
	xx = (is_position_relative * x) + xx;
	yy = (is_position_relative * y) + yy;
	
	// Platforms collision checking
	var platform_list = ds_list_create();
	
	var platform_count = instance_place_list(xx, yy, oPlatGhost, platform_list, true);
	if platform_count > 0 {
		var p = 0;
		var collided = false;
		repeat(platform_count) {
			var platform = ds_list_find_value(platform_list, p);
			
			switch(platform.image_angle) {
				case 90:
					collided = bbox_right <= platform.bbox_left or bbox_bottom <= platform.bbox_top;
					break;
				case 180:
					collided = bbox_top >= platform.bbox_bottom;
					break;
				case 270:
					collided = bbox_left >= platform.bbox_right or bbox_bottom <= platform.bbox_top;
					break;
				default:
					collided = bbox_bottom <= platform.bbox_top;
					break;
			}
			
			if collided {
				ds_list_destroy(platform_list);
				return true;
			}
			
			p++;
		}
	}
	
	ds_list_clear(platform_list);
	platform_count = instance_place_list(xx, yy, oPlatGhostL, platform_list, true);
	if (platform_count > 0) {
		var p = 0;
		repeat(platform_count) {
			var platform = ds_list_find_value(platform_list, p);
			if bbox_right <= platform.bbox_left or bbox_bottom <= platform.bbox_top {
				ds_list_destroy(platform_list);
				return true;
			}
			p++;
		}
	}
	
	ds_list_clear(platform_list);
	platform_count = instance_place_list(xx, yy, oPlatGhostR, platform_list, true);
	if (platform_count > 0) {
		var p = 0;
		repeat(platform_count) {
			var platform = ds_list_find_value(platform_list, p);
			if bbox_left >= platform.bbox_right or bbox_bottom <= platform.bbox_top {
				ds_list_destroy(platform_list);
				return true;
			}
			p++;
		}
	}
	
	ds_list_clear(platform_list);
	platform_count = instance_place_list(xx, yy, oPlatGhostInv, platform_list, true);
	if (platform_count > 0) {
		var p = 0;
		repeat(platform_count) {
			var platform = ds_list_find_value(platform_list, p);
			if bbox_top >= platform.bbox_bottom {
				ds_list_destroy(platform_list);
				return true;
			}
			p++;
		}
	}
	
	ds_list_destroy(platform_list);
	
	if place_meeting(xx, yy, oSolid) {
		return true;
	}
	
	return false;
}

function place_meeting_exception(argument0, argument1, argument2, argument3) {
	var exception = argument3;

	with (argument2) {
		// Allow 'other' access
		var this = id;
    
		if (id == exception)
		    continue;
		else
		    with (other)
		        if (place_meeting(argument0, argument1, this))
		            return true;
	}

	// Collision with a different object
	return false;
}