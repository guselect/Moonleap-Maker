/// @description freeze_game(spd/by)
/// @param spd/by
function scr_moving_plat() {
	if instance_exists(oPauseMenu) or instance_exists(oDead) {image_speed=0 exit;}
	if instance_exists(oTransition) { if oTransition.wait!=0 {image_speed=0 exit;} }
	if instance_exists(oPlayer) { if oPlayer.state=oPlayer.WIN {image_speed=0 exit;} }
	image_speed=1

	var hsp_new, vsp_new;

	// Handle sub-pixel movement
	cx += hsp
	cy += vsp
	hsp_new = floor(cx);
	vsp_new = floor(cy);
	cx -= hsp_new;
	cy -= vsp_new;

	//somente executa o código de movimento vertical se ele de fato tiver um
	if vsp!=0 {
		repeat (abs(vsp_new)) {
 
			if (place_meeting(x, y + sign(vsp_new), oBounce)) {vsp=0 break;} //se colodir com o oBounce, para de ler o código daqui pra baixo
	
			if (!place_meeting(x, y + sign(vsp_new), oSolid)) { //se não colidir com obj terreno
			
		        with (oPlayer) { //códigos relacionados ao movimento do player
		            if (place_meeting(x, y + 1, other.id)) and not(sign(vsp)=-1 and sign(vsp_new)=1)
					{
		                if (!place_meeting_exception(x, y + sign(vsp_new), oSolid, other.id))
		                    y += sign(vsp_new);
		            }
            
		            if (place_meeting(x, y - 1, other.id)) and sign(vsp_new)=1 //se a estiver indo pra cima e o player pra baixo não leva o player junto
		                y += sign(vsp_new);
            
		        }
				with (oSnail) { //códigos relacionados ao movimento do player
		            if (place_meeting(x, y + 1, other.id)) and not(sign(vsp)=-1 and sign(vsp_new)=1)
					{
		                if (!place_meeting_exception(x, y + sign(vsp_new), oSolid, other.id))
		                    y += sign(vsp_new);
		            }
            
		            if (place_meeting(x, y - 1, other.id)) and sign(vsp_new)=1 //se a estiver indo pra cima e o player pra baixo não leva o player junto
		                y += sign(vsp_new);
            
		        }
				with (oSnailNight) { //códigos relacionados ao movimento do player
		            if (place_meeting(x, y + 1, other.id)) and not(sign(vsp)=-1 and sign(vsp_new)=1)
					{
		                if (!place_meeting_exception(x, y + sign(vsp_new), oSolid, other.id))
		                    y += sign(vsp_new);
		            }
            
		            if (place_meeting(x, y - 1, other.id)) and sign(vsp_new)=1 //se a estiver indo pra cima e o player pra baixo não leva o player junto
		                y += sign(vsp_new);
            
		        }
				with (oMagicOrb) { //códigos relacionados ao movimento do player
		            if (place_meeting(x, y + 1, other.id)) and not(sign(vsp)=-1 and sign(vsp_new)=1)
					{
		                if (!place_meeting_exception(x, y + sign(vsp_new), oSolid, other.id))
		                    y += sign(vsp_new);
		            }
            
		            if (place_meeting(x, y - 1, other.id)) and sign(vsp_new)=1 //se a estiver indo pra cima e o player pra baixo não leva o player junto
		                y += sign(vsp_new);
            
		        }
			
				with (oSnailGray) { //códigos relacionados ao movimento do player
		            if (place_meeting(x, y + 1, other.id)) and not(sign(vsp)=-1 and sign(vsp_new)=1)
					{
		                if (!place_meeting_exception(x, y + sign(vsp_new), oSolid, other.id))
		                    y += sign(vsp_new);
		            }
            
		            if (place_meeting(x, y - 1, other.id)) and sign(vsp_new)=1 //se a estiver indo pra cima e o player pra baixo não leva o player junto
		                y += sign(vsp_new);
            
		        }
				
				y += sign(vsp_new) //código relacionado ao próprio movimento
		    }
		    else { //caso ele colida com o terreno, ele para e para de ler o código
		        vsp = 0;
		        break;
		    }
		}
	}

	repeat(abs(hsp_new)) {
	
		if sign(hsp_new)=1  and place_meeting(x + 1, y, oPlatGhostL) and !place_meeting(x, y, oPlatGhostL) {hsp=0 break;}
		if sign(hsp_new)=-1 and place_meeting(x - 1, y, oPlatGhostR) and !place_meeting(x, y, oPlatGhostR) {hsp=0 break;}
	
		// UP slope
		if (place_meeting(x + sign(hsp), y, oSolid) && place_meeting(x + sign(hsp), y - 1, oSolid) && !place_meeting(x + sign(hsp), y - 1, oSolid)) {
		    y -= 1; 
		} else if (place_meeting(x + sign(hsp), y, oSolid) && !place_meeting(x + sign(hsp), y - 1, oSolid)) {
		    y -= 1;  
		}
	
		// DOWN slope
		if vsp>=0
		{
			if (!place_meeting(x + sign(hsp), y, oSolid) && !place_meeting(x + sign(hsp), y + 1, oSolid) && !place_meeting(x + sign(hsp), y + 1, oSolid) && place_meeting(x + sign(hsp), y + 2, oSolid))
			  {  y += 1; }
			
			else if (!place_meeting(x + sign(hsp), y, oSolid) && !place_meeting(x + sign(hsp), y + 1, oSolid) && place_meeting(x + sign(hsp), y + 1, oSolid))
			    { y += 1;}
		}
	
		///Normal Terrain
	
		if (place_meeting(x + sign(hsp_new), y, oBounce)) {hsp=0 break;} //se colidir com o oBounce, para de ler o código daqui pra baixo
	
	    if (!place_meeting(x + sign(hsp_new), y, oSolid))  //se não colidir com obj terreno
		{
		
			with (oPlayer) //códigos relacionados ao movimento do player 
			{ 
		         if sign(hsp_new)=1 and (place_meeting(x -1, y, other.id))
		            {x += sign(hsp_new)}
				
				 if sign(hsp_new)=-1 and (place_meeting(x +1, y, other.id))
		            {x += sign(hsp_new)}
                    
		         if (!place_meeting(x + sign(hsp_new), y, oSolid) and (place_meeting(x,y+1, other.id))/* && platform_target == other.id*/)
		             x += sign(hsp_new);
		     }
			with (oSnail) //códigos relacionados ao movimento do player
			{ 
		         if sign(hsp_new)=1 and (place_meeting(x -1, y, other.id))
		            {x += sign(hsp_new)}
				
				 if sign(hsp_new)=-1 and (place_meeting(x +1, y, other.id))
		            {x += sign(hsp_new)}
                    
		         if (!place_meeting(x + sign(hsp_new), y, oSolid) and (place_meeting(x,y+1, other.id))/* && platform_target == other.id*/)
		             x += sign(hsp_new);
		     }
			with (oSnailNight) //códigos relacionados ao movimento do player
			{ 
		         if sign(hsp_new)=1 and (place_meeting(x -1, y, other.id))
		            {x += sign(hsp_new)}
				
				 if sign(hsp_new)=-1 and (place_meeting(x +1, y, other.id))
		            {x += sign(hsp_new)}
                    
		         if (!place_meeting(x + sign(hsp_new), y, oSolid) and (place_meeting(x,y+1, other.id))/* && platform_target == other.id*/)
		             x += sign(hsp_new);
		     }
			with (oSnailGray) //códigos relacionados ao movimento do player 
			{ 
		         if sign(hsp_new)=1 and (place_meeting(x -1, y, other.id))
		            {x += sign(hsp_new)}
				
				 if sign(hsp_new)=-1 and (place_meeting(x +1, y, other.id))
		            {x += sign(hsp_new)}
                    
		         if (!place_meeting(x + sign(hsp_new), y, oSolid) and (place_meeting(x,y+1, other.id))/* && platform_target == other.id*/)
		             x += sign(hsp_new);
		     }
			with (oMagicOrb) //códigos relacionados ao movimento do player
			{ 
		         if sign(hsp_new)=1 and (place_meeting(x -1, y, other.id))
		            {x += sign(hsp_new)}
				
				 if sign(hsp_new)=-1 and (place_meeting(x +1, y, other.id))
		            {x += sign(hsp_new)}
                    
		         if (!place_meeting(x + sign(hsp_new), y, oSolid) and (place_meeting(x,y+1, other.id))/* && platform_target == other.id*/)
		             x += sign(hsp_new);
		     }
		
			x += sign(hsp_new) 
	    }
	    else { //caso ele colida com o terreno, ele para e para de ler o código
		
			/////////////////////
		
	        hsp = 0;
	        break;
	    }
	}
}
