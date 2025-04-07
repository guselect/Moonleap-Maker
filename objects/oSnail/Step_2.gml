/// @description Insert description here
// You can write your code in this editor
if instance_exists(oPauseMenu) or instance_exists(oDead) {image_speed=0 exit;}			if instance_exists(oTransition) { if oTransition.wait!=0 {image_speed=0 exit;} }; if instance_exists(oPlayer) { if oPlayer.state=oPlayer.WIN {image_speed=0 exit;} }




image_speed=1


/// @description Insert description here
// You can write your code in this editor
// Handle sub-pixel movement



cx +=(( hsp*(abs(night-1)))* on_ground_var) +hsp_plus
cy += vsp
var hsp_new = floor(cx);
var vsp_new = floor(cy);
cx -= hsp_new;
cy -= vsp_new;

jumped = false;
landed = false;



repeat(abs(vsp_new)) {
    if (not has_collided(0, 1, true, [oPermaSpike]))
        y += sign(vsp);
    else  {
        vsp = 0;
        break;
    }
}


//repeat(abs(hsp_new)) {        
//    if (!place_meeting(x + sign(hsp), y, oSolid))
//        x += sign(hsp);
//   else {
//       hsp = 0;
//        break;
//    }
//}

////slopes

repeat(abs(hsp_new)) 
{
	if sign(hsp_new) == 1 and  place_meeting(x + 1, y, oPlatGhostL) and !place_meeting(x, y, oPlatGhostL) {hsp=0 break;}
	if sign(hsp_new) == -1 and place_meeting(x - 1, y, oPlatGhostR) and !place_meeting(x, y, oPlatGhostR) {hsp=0 break;}
	
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


