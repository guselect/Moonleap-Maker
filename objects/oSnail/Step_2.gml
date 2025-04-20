if instance_exists(oPauseMenu) 
or instance_exists(oDead)
or (instance_exists(oTransition) and oTransition.wait != 0)
or (instance_exists(oPlayer) and oPlayer.state == PLAYER_STATE.WIN) {
	image_speed = 0; 
	exit;
}

image_speed = 1;

var _cx = ((hsp * abs(night - 1)) * on_ground_var) + hsp_plus;

scr_moving_plat(_cx);


//// Handle sub-pixel movement
//cx += (( hsp*(abs(night-1)))* on_ground_var) +hsp_plus
//cy += vsp
//var hsp_new = floor(cx);
//var vsp_new = floor(cy);
//cx -= hsp_new;
//cy -= vsp_new;

//jumped = false;
//landed = false;

//// Vertical collision
//repeat(abs(vsp_new)) {
//    if (not has_collided(0, 1, true, [oPermaSpike]))
//        y += sign(vsp);
//    else  {
//        vsp = 0;
//        break;
//    }
//}

//// Horizontal collision
//repeat(abs(hsp_new)) {
//	// Going up slopes
//	if place_meeting(x + sign(hsp), y, oSolid)
//	and not place_meeting(x + sign(hsp), y - 1, oSolid) {
//		y -= 1;  
//	}
	
//	// Going down slopes
//	if vsp >= 0
//	and not place_meeting(x + sign(hsp), y, oSolid)
//	and not place_meeting(x + sign(hsp), y + 1, oSolid)
//	and place_meeting(x + sign(hsp), y + 2, oSolid) {
//		y += 1;
//	}
	
//	if has_collided(sign(hsp), 0, true, [oPermaSpike]) {
//		hsp = 0;
//		break;
//	}
	
//	x += sign(hsp);
//}


