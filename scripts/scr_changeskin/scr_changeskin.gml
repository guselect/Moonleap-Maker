function scr_changeskin() {
	var oldskin = oCamera.current_skin;
	
	oCamera.current_skin += 1;
	
	scr_checkskin();
	
	//only flash if the player changes the skin
	if oldskin != oCamera.current_skin {
		flash = 1
		audio_play_sfx(snd_morcego_move_02, false, -20, 15);
	} 
}

function scr_checkskin() { 

	//read the save
	var s1 = oSaveManager.struct_main[$ "s1"]
	var s2 = oSaveManager.struct_main[$ "s2"]
	var s3 = oSaveManager.struct_main[$ "s3"]
	var s4 = oSaveManager.struct_main[$ "s4"]
	var s5 = oSaveManager.struct_main[$ "s5"]
	var s6 = oSaveManager.struct_main[$ "s6"]
	var s7 = oSaveManager.struct_main[$ "s7"]

	if oCamera.current_skin == 1 and not s1 then oCamera.current_skin += 1;
	if oCamera.current_skin == 2 and not s2 then oCamera.current_skin += 1;
	if oCamera.current_skin == 3 and not s3 then oCamera.current_skin += 1;
	if oCamera.current_skin == 4 and not s4 then oCamera.current_skin += 1;
	if oCamera.current_skin == 5 and not s5 then oCamera.current_skin += 1;
	if oCamera.current_skin == 6 and not s6 then oCamera.current_skin += 1;
	if oCamera.current_skin == 7 and not s7 then oCamera.current_skin += 1;
	if oCamera.current_skin == 8 then oCamera.current_skin = 0;

	switch (oCamera.current_skin) {
		case 0:
			PlayerIdle=			sPlayerIdle
			PlayerRun=			sPlayerRun
			PlayerJump=			sPlayerJump
			PlayerSit=			sPlayerSit
			PlayerClimb=		sPlayerClimb
			PlayerDead=			sPlayerDead
			PlayerEnding=		sPlayerEnding
			PlayerEndingFlash=	sPlayerEndingFlash
			PlayerHappy=		sPlayerHappy
			break;
		
		case 1:
			PlayerIdle=			sPlayerIdle1
			PlayerRun=			sPlayerRun1
			PlayerJump=			sPlayerJump1
			PlayerSit=			sPlayerSit1
			PlayerClimb=		sPlayerClimb1
			PlayerDead=			sPlayerDead1
			PlayerEnding=		sPlayerEnding1
			PlayerEndingFlash=	sPlayerEndingFlash1
			PlayerHappy=		sPlayerHappy1
			break;
		
		case 2:
			PlayerIdle=			sPlayerIdle2
			PlayerRun=			sPlayerRun2
			PlayerJump=			sPlayerJump2
			PlayerSit=			sPlayerSit2
			PlayerClimb=		sPlayerClimb2
			PlayerDead=			sPlayerDead2
			PlayerEnding=		sPlayerEnding2
			PlayerEndingFlash=	sPlayerEndingFlash2
			PlayerHappy=		sPlayerHappy2
			break;
			
		case 3:
			PlayerIdle=			sPlayerIdle3
			PlayerRun=			sPlayerRun3
			PlayerJump=			sPlayerJump3
			PlayerSit=			sPlayerSit3
			PlayerClimb=		sPlayerClimb3
			PlayerDead=			sPlayerDead3
			PlayerEnding=		sPlayerEnding3
			PlayerEndingFlash=	sPlayerEndingFlash3
			PlayerHappy=		sPlayerHappy3
			break;
		case 4:
			PlayerIdle=			sPlayerIdle4
			PlayerRun=			sPlayerRun4
			PlayerJump=			sPlayerJump4
			PlayerSit=			sPlayerSit4
			PlayerClimb=		sPlayerClimb4
			PlayerDead=			sPlayerDead4
			PlayerEnding=		sPlayerEnding4
			PlayerEndingFlash=	sPlayerEndingFlash4
			PlayerHappy=		sPlayerHappy4
			break;
		case 5:
			PlayerIdle=			sPlayerIdle5
			PlayerRun=			sPlayerRun5
			PlayerJump=			sPlayerJump5
			PlayerSit=			sPlayerSit5
			PlayerClimb=		sPlayerClimb5
			PlayerDead=			sPlayerDead5
			PlayerEnding=		sPlayerEnding5
			PlayerEndingFlash=	sPlayerEndingFlash5
			PlayerHappy=		sPlayerHappy5
		case 6:
			PlayerIdle=			sGhost
			PlayerRun=			sGhost
			PlayerJump=			sGhost
			PlayerSit=			sGhost
			PlayerClimb=		sGhost
			PlayerDead=			sGhost
			PlayerEnding=		sGhost
			PlayerEndingFlash=	sGhost
			PlayerHappy=		sGhost
			break;
		case 7:
			PlayerIdle=			sPlayerIdle7
			PlayerRun=			sPlayerRun7
			PlayerJump=			sPlayerJump7
			PlayerSit=			sPlayerSit7
			PlayerClimb=		sPlayerClimb7
			PlayerDead=			sPlayerDead7
			PlayerEnding=		sPlayerEnding7
			PlayerEndingFlash=	sPlayerEndingFlash7
			PlayerHappy=		sPlayerHappy7
	}
}

