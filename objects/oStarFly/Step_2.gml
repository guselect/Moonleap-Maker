//cx += 0
//cy += 0
//var hsp_new = floor(cx);
//var vsp_new = floor(cy);
//cx -= hsp_new;
//cy -= vsp_new;

//jumped = false;
//landed = false;



//repeat(abs(vsp_new)) {
//    if (!platform_check()) and !place_meeting(x,y+1,oPermaSpike)
//        y += sign(vsp);
//    else  {
//        vsp = 0;
//        break;
//    }
//}


////repeat(abs(hsp_new)) {        
////    if (!place_meeting(x + sign(hsp), y, oSolid))
////        x += sign(hsp);
////   else {
////       hsp = 0;
////        break;
////    }
////}

//////slopes

//tempH=1
//repeat(abs(hsp_new)) 
//{
//	// UP slope
//	if (place_meeting(x + sign(hsp), y, oSolid) && place_meeting(x + sign(hsp), y - 1, oSolid) && !place_meeting(x + sign(hsp), y - 2, oSolid)) {
//	    y -= 2;
//	} else if (place_meeting(x + sign(hsp), y, oSolid) && !place_meeting(x + sign(hsp), y - 1, oSolid)) {
//	    y -=1;
//	}
	
//	// DOWN slope
//	if vsp>=0
//	{
//		if (!place_meeting(x + sign(hsp), y, oSolid) && !place_meeting(x + sign(hsp), y + 1, oSolid) && !place_meeting(x + sign(hsp), y + 2, oSolid) && place_meeting(x + sign(hsp), y + 3, oSolid))
//		  {  y += 2; }
			
//		else if (!place_meeting(x + sign(hsp), y, oSolid) && !place_meeting(x + sign(hsp), y + 1, oSolid) && place_meeting(x + sign(hsp), y + 2, oSolid))
//		    { y += 1; }
//	}
	
//	//Normal Terrain
//	if (!place_meeting(x + sign(hsp), y, oSolid))
//		{x += sign(hsp)*tempH} else { hsp = 0; break;}
		
		
//}