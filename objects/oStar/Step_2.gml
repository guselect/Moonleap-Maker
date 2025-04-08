cx += hsp 
cy += vsp
var hsp_new = floor(cx);
var vsp_new = floor(cy);
cx -= hsp_new;
cy -= vsp_new;

jumped = false;
landed = false;



// Vertical collision
repeat(abs(vsp_new)) {
	if has_collided(0, sign(vsp), true, [oPermaSpike]) {
		vsp = 0;
        break;
	}
	
	y += sign(vsp);
}

// Horizontal collision
repeat(abs(hsp_new)) {
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
	
	if has_collided(sign(hsp), 0, true, [oPermaSpike]) {
		hsp = 0;
		break;
	}
	
	x += sign(hsp);
}
