 

//snails dont like ramps


if(GooglePlayServices_IsAvailable())
{
    //show_debug_message("GooglePlayServices Available")
    //Do something
}

//if(steam_initialised())show_message("foi")

if (on_desktop()) {
	steam_update();
}

//audio_param_set("NightParameter", smoothnight)

if debug {
	arcade = false;
    if !surface_exists(surfdebug) {
        surfdebug=-1
    } 
}

//if global.settings.enable_sfx=true
	//{
		////smoothnight=approach(smoothnight,night*100,10)
	//}
//else
	//{
		////smoothnight=approach(smoothnight,night*100,1)
	//}

if instance_exists(oPlayer)
and instance_exists(oTransition)
and oPlayer.state == PLAYER_STATE.WIN {
    smoothnight = approach(smoothnight, 0, 20);
}

shaketime = approach(shaketime, 0, 1);

if (shaketime == 0) {
	if (os_type == os_switch) {
		gamepad_set_vibration(global.switch_controller_id,0,0);
	}
	else {
		gamepad_set_vibration(0,0,0);
		gamepad_set_vibration(1,0,0);
	}
}


if !instance_exists(oPlayer) and room!=RoomCreditsAlves and room!=RoomProgress and room!=RoomMaker0
{
	
 {if !instance_exists(oTransition) {var trans=instance_create_layer(x,y,layer,oTransition) trans.target_room=room}}
}

//if levelnumb<20 and levelnumb>=8 {image_speed=2 with(oDust){y+=0.25}}


if keyboard_check_pressed(ord("P"))
{
	if show_debug=true {show_debug=false} else {show_debug=true}
}





////////////////////////CAMERA STUFF///////////////////////

if instance_exists(oTransition) {apspd=1} else {apspd=0.05} 

if shake!=0
{shake=approach(shake,0,0.1)

//x=xstart+random_range(-shake,shake)
//y=ystart+random_range(-shake,shake)

}

if instance_exists(oPlayer) and room=Room100
{
	
	py=oPlayer.y
	px=oPlayer.x
	
	if collision_point(oPlayer.x,oPlayer.y,oCameraLock,true,true)
	{
	py=400
	}
		
		if (room_height!=180)
		{
			if (py > huby+view_height) {
				huby_prev = huby;
				huby += view_height; 
				hubcheck = true; 
				hubmoving = true;
			}
			else if (py < huby) { 
				huby_prev = huby;
				huby -= view_height; 
				hubcheck = true;
				hubmoving = true;
			}
			huby = clamp(huby,0,view_height*3);
			y=smooth_approach(y,huby,apspd)
			
			/*if point_distance(x,py,x,view_height/2)<90 {y=smooth_approach(y,0,apspd)}
			if point_distance(x,py,x,view_height+view_height/2)<90  {y=smooth_approach(y,view_height,apspd)}
			if point_distance(x,py,x,view_height*2+(view_height/2))<90 {y=smooth_approach(y,view_height*2,apspd)}
			if point_distance(x,py,x,view_height*3+(view_height/2))<90 {y=smooth_approach(y,view_height*3,apspd)}*/

			hubaudiocol=collision_point(px,py,ohubaudiocontrol,false,false);
			
			if (hubaudiocol!=noone)
			{
				if (hubaudiocol.col=false)
				{
					with(hubaudiocol) {scr_hubchange()} hubaudiocol.col=true show_debug_message("transition trigger")
				}
			}
			
	
			if (room_width!=320)
			{
				if (px > hubx+view_width) {	
					hubx_prev = hubx;
					hubx += view_width; 
					hubcheck = true; 
					hubmoving = true;
				}
				else if (px < hubx) { 
					hubx_prev = hubx;
					hubx -= view_width; 
					hubcheck = true; 
					hubmoving = true;
				}
				hubx = clamp(hubx,0,view_width*7);
				x=smooth_approach(x,hubx,apspd);
				
				
			}
			
			if (hubmoving && (x == hubx) && (y == huby)) {
				hubmoving = false;
				hubx_prev = hubx;
				huby_prev = huby;
				hubcheck = true;
			}
		

}

}
	if instance_exists(oPlayerEnding)
	{
		if oPlayerEnding.y=180/2 {y=smooth_approach(y,(oPlayerEnding.y-106)+16,apspd)} else {y=oPlayerEnding.y-106}
		}
	

