cx += hsp 
cy += vsp
var hsp_new = floor(cx);
var vsp_new = floor(cy);
cx -= hsp_new;
cy -= vsp_new;

jumped = false;
landed = false;


repeat(abs(vsp_new)) {
	if has_collided(0, sign(vsp)) {
		vsp = 0;
        break;
	}
	
	y += sign(vsp);
}

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
	
	if has_collided(sign(hsp), 0) {
		hsp = 0;
		break;
	}
	
	x += sign(hsp);
	
	//// Normal Terrain
	//if sign(hsp) == 1
	//{
	//	if (not place_meeting(x + 1, y, oSolid)) 
	//		and not (place_meeting(x + 1, y, oPlatGhostL) and not place_meeting(x, y, oPlatGhostL)) 
	//		and not (place_meeting(x + 1, y, oMagicOrb) and not place_meeting(x, y, oMagicOrb))
	//	{
	//		x += sign(hsp);
	//	} else { 
	//		hsp = 0;
	//		break;
	//	}
	//}
	
	//if sign(hsp) == -1
	//{
	//	if (!place_meeting(x - 1, y, oSolid))
	//		and not (place_meeting(x - 1, y, oPlatGhostR) and !place_meeting(x, y, oPlatGhostR))
	//		and !(place_meeting(x - 1, y, oMagicOrb) and !place_meeting(x, y, oMagicOrb))
	//	{
	//		x += sign(hsp);
	//	} else {
	//		hsp = 0;
	//		break;
	//	}
	//}
}

if oCamera.current_skin=5
{
	if oCamera.night=false
	{
		PlayerIdle=		sPlayerIdle5
		PlayerRun=		sPlayerRun5
		PlayerJump=		sPlayerJump5
		PlayerSit=		sPlayerSit5
		PlayerClimb=	sPlayerClimb5
		PlayerDead=		sPlayerDead5
		PlayerEnding=	sPlayerEnding5
		PlayerHappy=	sPlayerHappy5
	}
	else
	{
		
		PlayerIdle=		sPlayerIdle6
		PlayerRun=		sPlayerRun6
		PlayerJump=		sPlayerJump6
		PlayerSit=		sPlayerSit6
		PlayerClimb=	sPlayerClimb6
		PlayerDead=		sPlayerDead6
		PlayerEnding=	sPlayerEnding6
		PlayerHappy=	sPlayerHappy6		
	}
}


if room=Room100
{
	if y>360 and y<720 {trueblack=false} else {trueblack=true}
	}


//PORTAL STUFF
if gowhite=true
{
	var nearp= instance_nearest(x,y,oPortal)
	white+=gowhite/4
	grav=0
	vsp=0
	hsp=0
	x=smooth_approach(x,nearp.x,0.1)
	y=smooth_approach(y,nearp.y+6,0.1)
}
