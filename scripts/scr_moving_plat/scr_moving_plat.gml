function scr_moving_plat(_cx = hsp, _cy = vsp) {
	if (instance_exists(oPauseMenu) or instance_exists(oDead))
	or (instance_exists(oTransition) and oTransition.wait != 0)
	or (not instance_exists(oPlayer) or (instance_exists(oPlayer) and oPlayer.state == PLAYER_STATE.WIN)) {
		image_speed = 0;
		exit;
	}

	image_speed = 1;

	// Handle sub-pixel movement
	cx += _cx;
	cy += _cy;
	var hsp_new = floor(cx);
	var vsp_new = floor(cy);
	cx -= hsp_new;
	cy -= vsp_new;

	// Movimento vertical
	if vsp != 0 {
		repeat(abs(vsp_new)) {
			// Se colidir com o oBounce, para de ler o código daqui pra baixo
			if (place_meeting(x, y + sign(vsp_new), oBounce)) {
				vsp = 0;
				break;
			} 
			
			// Se não colidir com terreno verticalmente
			if (not has_collided(0, sign(vsp_new))) {
		        with (oPlayer) {
					if (place_meeting(x, y + 1, other.id)
						and not (sign(vsp) == -1 and sign(vsp_new) == 1)
						and not place_meeting_exception(x, y + sign(vsp_new), oSolid, other.id)
					) or (place_meeting(x, y - 1, other.id) 
						and sign(vsp_new) == 1
					) {
						y += sign(vsp_new);
					}
		        }
				
				// Movimento do caracol do dia
				with (oSnail) { 
					if (place_meeting(x, y + 1, other.id)
						and not (sign(vsp) == -1 and sign(vsp_new) == 1)
						and not place_meeting_exception(x, y + sign(vsp_new), oSolid, other.id)
					) or (place_meeting(x, y - 1, other.id) 
						and sign(vsp_new) == 1
					) {
						y += sign(vsp_new);
					}
		        }
				
				with (oSnailNight) { // Movimento do caracol da noite
					if (place_meeting(x, y + 1, other.id)
						and not (sign(vsp) == -1 and sign(vsp_new) == 1)
						and not place_meeting_exception(x, y + sign(vsp_new), oSolid, other.id)
					) or (place_meeting(x, y - 1, other.id) 
						and sign(vsp_new) == 1
					) {
						y += sign(vsp_new);
					}
		        }
				
				// Movimento do orbe mágico
				with (oMagicOrb) { 
					if (place_meeting(x, y + 1, other.id)
						and not (sign(vsp) == -1 and sign(vsp_new) == 1)
						and not place_meeting_exception(x, y + sign(vsp_new), oSolid, other.id)
					) or (place_meeting(x, y - 1, other.id) 
						and sign(vsp_new) == 1
					) {
						y += sign(vsp_new);
					}
		        }
			
				// Movimento do caracol neutro
				with (oSnailGray) { 
					if (place_meeting(x, y + 1, other.id)
						and not (sign(vsp) == -1 and sign(vsp_new) == 1)
						and not place_meeting_exception(x, y + sign(vsp_new), oSolid, other.id)
					) or (place_meeting(x, y - 1, other.id) 
						and sign(vsp_new) == 1
					) {
						y += sign(vsp_new);
					}
		        }
				
				y += sign(vsp_new) //código relacionado ao próprio movimento
		    }
		    else { //caso ele colida com o terreno, ele para e para de ler o código
		        vsp = 0;
		        break;
		    }
		}
	}

	// Movimento horizontal
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
	
		///Normal Terrain
	
		//se colidir com o oBounce, para de ler o código daqui pra baixo
		if (place_meeting(x + sign(hsp_new), y, oBounce)) {
			hsp = 0; 
			break;
		} 
		
		// Se não colidir com terreno, mova os seguintes objetos acima dele.
	    if (not has_collided(sign(hsp_new), 0, true, [oPermaSpike])) {
			// Movimento do player
			with (oPlayer) { 
				if place_meeting(x - sign(hsp_new), y, other.id)
				or (not has_collided(sign(hsp_new), 0) and place_meeting(x, bbox_bottom + 1, other.id)) {
					x += sign(hsp_new);
				}
		    }
			// Movimento do caracol do dia
			with (oSnail) { 
				if place_meeting(x - sign(hsp_new), y, other.id)
				or (not has_collided(sign(hsp_new), 0) and place_meeting(x, bbox_bottom + 1, other.id)) {
					x += sign(hsp_new);
				}
		    }
			 
			// Movimento do caracol da noite
			with (oSnailNight) { 
				if place_meeting(x - sign(hsp_new), y, other.id)
				or (not has_collided(sign(hsp_new), 0) and place_meeting(x, bbox_bottom + 1, other.id)) {
					x += sign(hsp_new);
				}
		    }
			
			// Movimento do caracol neutro
			with (oSnailGray) { 
				if place_meeting(x - sign(hsp_new), y, other.id)
				or (not has_collided(sign(hsp_new), 0) and place_meeting(x, bbox_bottom + 1, other.id)) {
					x += sign(hsp_new);
				}
		    }
			
			// Movimento da estrela
			with (oStar) { 
				if place_meeting(x - sign(hsp_new), y, other.id)
				or (not has_collided(sign(hsp_new), 0) and place_meeting(x, bbox_bottom + 1, other.id)) {
					x += sign(hsp_new);
				}
		    }
			
			// Movimento do orbe mágico
			with (oMagicOrb) { 
				if place_meeting(x - sign(hsp_new), y, other.id)
				or (not has_collided(sign(hsp_new), 0) and place_meeting(x, bbox_bottom + 1, other.id)) {
					x += sign(hsp_new);
				}
		    }
		
			x += sign(hsp_new);
	    } else {
	        hsp = 0;
	        break;
	    }
	}
}
