apply_movement_collision();

if is_at_hub() {
  trueblack = not (y > 360 and y < 720);
}

if oCamera.current_skin == 5 {
	if not oCamera.night {
		PlayerIdle=		sPlayerIdle5
		PlayerRun=		sPlayerRun5
		PlayerJump=		sPlayerJump5
		PlayerSit=		sPlayerSit5
		PlayerClimb=	sPlayerClimb5
		PlayerDead=		sPlayerDead5
		PlayerEnding=	sPlayerEnding5
		PlayerHappy=	sPlayerHappy5
	} else {
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

//PORTAL STUFF
if gowhite {
	var nearp = instance_nearest(x, y, oPortal);

	white += gowhite / 4;
	v_grav = 0;
	vsp = 0;
	hsp = 0;
	x = smooth_approach(x,nearp.x,0.1)
	y = smooth_approach(y,nearp.y+6,0.1)
}

image_xscale = move;