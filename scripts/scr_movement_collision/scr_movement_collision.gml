/// @param {real} xx The horizontal position.
/// @param {real} yy The vertical position.
/// @param {bool} is_position_relative If true, the xx and yy positions are relative to the object position.
/// If false, they are relative to the room position. Default: true
/// @param {Array<Asset.GMObject>} included_objects An array of objects to be also checked as collision. Default: empty array

function has_collided(xx, yy, is_position_relative = true, included_objects = []) {
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
	
	for (var i = 0; i < array_length(included_objects); i++) {
		var included_object = included_objects[i]
		if place_meeting(xx, yy, included_object) {
			return true;	
		}
	}
	
	if place_meeting(xx, yy, oSolid) {
		return true;
	}
	
	return false;
}

function apply_movement_and_collision() {
	var steps_x = ceil(abs(hsp));
	var steps_y = ceil(abs(vsp));
	
	// Vertical collision
	repeat(steps_x) {
		if has_collided(0, sign(vsp)) {
			vsp = 0;
	        break;
		}
	
		y += sign(vsp);
	}

	// Horizontal collision
	repeat(steps_y) {
		// Going up slopes
		if place_meeting(x + sign(hsp), y, oSolid)
		and not place_meeting(x + sign(hsp), y - 1, oSolid) {
			y -= 1;  
		}
	
		// Going down slopes
		if vsp >= 0
		and not place_meeting(x + sign(hsp), y, oSolid)
		and not place_meeting(x + sign(hsp), y + 1, oSolid)
		and place_meeting(x + sign(hsp), y + 2, oSolid) {
			y += 1;
		}
	
		if has_collided(sign(hsp), 0) {
			hsp = 0;
			break;
		}
	
		x += sign(hsp);
	}
}