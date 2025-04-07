if instance_exists(oPauseMenu) or instance_exists(oDead) {image_speed=0 exit;}
if instance_exists(oTransition) { if oTransition.wait!=0 {image_speed=0 exit;}}
if instance_exists(oPlayer) { if oPlayer.state=oPlayer.WIN {image_speed=0 exit;}}
image_speed=1

// Handle sub-pixel movement


cx += hsp 
cy += vsp
var hsp_new = floor(cx);
var vsp_new = floor(cy);
cx -= hsp_new;
cy -= vsp_new;

jumped = false;
landed = false;

if vsp!=0 {hsp_new=0}

// Vertical collision
repeat(abs(vsp_new)) {
	if has_collided(0, sign(vsp)) {
		vsp = 0;
	    break;
	}
	
	y += sign(vsp);
}

// Horizontal collision
repeat(abs(hsp_new)) {
	// UP slope
	if (place_meeting(x + sign(hsp), y, oSolid) && place_meeting(x + sign(hsp), y - 1, oSolid) && !place_meeting(x + sign(hsp), y - 2, oSolid)) {
	    y -= 2;
	} else if (place_meeting(x + sign(hsp), y, oSolid) && !place_meeting(x + sign(hsp), y - 1, oSolid)) {
	    y -=1;
	}
	
	// DOWN slope
	if vsp>=0
	{
		if (!place_meeting(x + sign(hsp), y, oSolid) && !place_meeting(x + sign(hsp), y + 1, oSolid) && !place_meeting(x + sign(hsp), y + 2, oSolid) && place_meeting(x + sign(hsp), y + 3, oSolid))
		  {  y += 2; }
			
		else if (!place_meeting(x + sign(hsp), y, oSolid) && !place_meeting(x + sign(hsp), y + 1, oSolid) && place_meeting(x + sign(hsp), y + 2, oSolid))
		    { y += 1; }
	}
	
	//Normal Terrain
	if (!place_meeting(x + sign(hsp), y, oSolid)) and (!place_meeting(x + sign(hsp), y, oPermaSpike))
		{x += sign(hsp)} else { hsp = 0; break;}
}