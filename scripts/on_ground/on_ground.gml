/// @description  OnGround();
function on_ground() {
	if vsp < 0 {
		return false
	}
	
	return place_meeting(x, y + 1, oSolid) or (place_meeting(x, y + 1, oPlatGhost) and not place_meeting(x, y, oPlatGhost))
}