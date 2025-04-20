if not instance_exists(oPlayer) then exit;

if change and instance_exists(oPlayer) and cooldown=0 {
	cooldown = 10;
	x = oPlayer.x;
	y = oPlayer.y;
	oPlayer.x = xprevious;
	oPlayer.y = yprevious;
	oPlayer.flash = true;
	flash = true;
	
	instance_create_layer(x,y,layer,oGemSpark)
	
	var sfxcogu = choose(snd_warp,snd_warp2,snd_warp3);
    audio_play_sfx(sfxcogu,false,-14,2)
	change = false;
	scr_change_orb()
	
    night = not oPlayer.night;
}

if instance_exists(oPauseMenu) 
or instance_exists(oDead)
or (instance_exists(oTransition) and oTransition.wait != 0)
or (instance_exists(oPlayer) and oPlayer.state == PLAYER_STATE.WIN) {
    image_speed = 0;
    exit;
}

var hsp_new, vsp_new;

// Handle sub-pixel movement
cx += hsp
cy += vsp
hsp_new = floor(cx);
vsp_new = floor(cy);
cx -= hsp_new;
cy -= vsp_new;

//somente executa o código de movimento vertical se ele de fato tiver um
if vsp != 0 {
	repeat (abs(vsp_new)) {
    
        // se colodir com o oBounce, para de ler o código daqui pra baixo
		if (place_meeting(x, y + sign(vsp_new), oBounce)) {
            vsp = 0;
            break;
        } 
	
        // se não colidir com obj terreno
		if (not place_meeting(x, y + sign(vsp_new), oSolid)) { 
			y += sign(vsp_new) //código relacionado ao próprio movimento
	    } else { //caso ele colida com o terreno, ele para e para de ler o código
	        vsp = 0;
	        break;
	    }
	}
}

repeat(abs(hsp_new)) {
	
	if (sign(hsp_new) == 1 and place_meeting(x + 1, y, oPlatGhostL) and not place_meeting(x, y, oPlatGhostL))
    or (sign(hsp_new) == -1 and place_meeting(x - 1, y, oPlatGhostR) and not place_meeting(x, y, oPlatGhostR)) {
        hsp = 0;
        break;
    }

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
	
    // Se colodir com o oBounce, para de ler o código daqui pra baixo
	if (place_meeting(x + sign(hsp_new), y, oBounce)) {
        hsp = 0 
        break;
    } 
	
    //se não colidir com obj terreno
    if (!place_meeting(x + sign(hsp_new), y, oSolid)) {
		x += sign(hsp_new) 
    	
    	var ran = irandom_range(1, 3);
    	if on_ground_var and ran == 1 {
        	var dust = instance_create_layer(x, bbox_bottom + 1, "Instances_2", oBigDust);
        	dust.hsp = hsp / random_range(5, 10);
        	dust.vsp = vsp / random_range(5, 10);
    	}
		
    }
    else { //caso ele colida com o terreno, ele para e para de ler o código
        hsp = 0;
        break;
    }
}
