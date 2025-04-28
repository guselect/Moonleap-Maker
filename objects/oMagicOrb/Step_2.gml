if not instance_exists(oPlayer) then exit;

if change and instance_exists(oPlayer) and cooldown == 0 {
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
or (instance_exists(oPlayer) and oPlayer.state.state_is("win")) {
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
		if not has_collided(0, sign(vsp_new)) { 
			y += sign(vsp_new);
		} else {
		   vsp = 0;
		   break;
		}
	}
}

repeat(abs(hsp_new)) {
	// Going up slopes
	if has_collided(sign(hsp), 0)
	and not has_collided(sign(hsp), -1) {
		y -= 1;  
	}
	
	// Going down slopes
	if vsp >= 0
	and not has_collided(sign(hsp), 0)
	and not has_collided(sign(hsp), 1)
	and has_collided(sign(hsp), 2) {
		y += 1;
	}
	
   //se não colidir com obj terreno
	 
	if not has_collided(sign(hsp_new), 0) {
		x += sign(hsp_new);
    	
	   var ran = irandom_range(1, 3);
	   if on_ground_var and ran == 1 {
	      var dust = instance_create_layer(x, bbox_bottom + 1, "Instances_2", oBigDust);
	      dust.hsp = hsp / random_range(5, 10);
	      dust.vsp = vsp / random_range(5, 10);
	   }
   } else {
      hsp = 0;
      break;
   }
}
