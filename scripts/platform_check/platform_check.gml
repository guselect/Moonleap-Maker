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