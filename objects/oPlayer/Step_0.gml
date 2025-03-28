//show_debug_message("oPlayer.star:" + string(star));
//show_debug_message("oPlayer.inistar:" + string(inistar));

var ghost= (PlayerIdle=	sGhost)
if on_ground_var=false and on_ground()=true 
{
	if !instance_exists(oTransition) {shake_gamepad(1,3)}
	repeat(random_range(3,5))
	{
		var dust=instance_create_layer(x,y+(sprite_height/2),"Instances_2",oBigDust)
		dust.hsp=random_range(-0.5,0.5)+(hsp/5)
	}
}

on_ground_var = on_ground()

	if key_left=true {key_right=false}

// RESET (suicide)
if debug_mode=false and state!=WIN 
{
	if !instance_exists(oMenu) and !instance_exists(oPauseMenu) and !instance_exists(oIntro) and !instance_exists(oTransition)
	{
		if room!=RoomMenu and room!=RoomMenu2 and room!=RoomFinal and room!=RoomCredits and room!=RoomCreditsAlves and room!=RoomProgress
		{
			if room=Room100
			{if place_meeting(x,y,oSpecial5Trigger) and instance_exists(oSpecial5) { if key_reset=true { oSpecial5.done=true instance_destroy()}}}
			else
			{if key_reset=true {instance_destroy()}}
			
		}
	}
}



#region Movimentação + Pulo

// Wall cling to avoid accidental push-off
if ((!key_right && !key_left) || on_ground_var) {
    can_stick = true;
    sticking = false;
} else if (((key_right && key_left) || (key_left && key_right)) && can_stick && !on_ground_var) {
    alarm[0] = cling_time;
    sticking = true; 
    can_stick = false;       
}


if(key_left or key_right or key_jump_pressed){
	alarm[11] = game_get_speed(gamespeed_fps) * 30;
}

if(room == Room100 or instance_exists(oPauseMenu)){
	alarm[11]+=1;
}


//Horizontal movement


// Left 
if (key_left && !key_right && !sticking) 
{
    move = -1;
    state  = RUN;
  
    if hsp> -(v_max) {hsp = approach(hsp, -(v_max) , v_ace)}

// Right
} else if (key_right && !key_left && !sticking) {
    move = 1;
    state  = RUN;
    
    if hsp<(v_max)  {hsp = approach(hsp, (v_max) , v_ace)}
}

image_angle=0
//hsp=clamp(hsp,-v_max,v_max)//limitar hsp

	// Friction
	if (!key_right && !key_left) {
	    hsp    = approach(hsp, 0, v_fric);
	    state = IDLE;
	} 


//Vertical movement

if on_ground_var

{
	grace_time= grace_time_frames
	last_plat=instance_place(x,y+6,oBrokenStone)

}
else// if on_ladder=false
{
	if vsp>-1 and vsp<1 {grav=0.09} else {grav=0.125}
	vsp = approach(vsp,3+(key_down*2),grav) //gravidade limitada por 4 de vsp 
	grace_time=approach(grace_time,0,1) + ghost
	
	
}

// Jump
if key_jump_pressed 
	and not place_meeting(x,y,oLadderParent)
	and not key_down 
	and not place_meeting(x,y - 2, oSolid)
{
	#region Stick to the floor
	if vsp > -1 {	
		if not night {
			var otherspike = instance_place(x, y + 6, oParentNight);
			if otherspike != noone {
				y += otherspike.bbox_top - (y + 10); //é 10 porque sprite_height/2=9
				
				if not place_meeting(x,y,oNope) 
					and state != WIN 
					and not godmode then instance_destroy();
			} 
		} else {
			var otherspike = instance_place(x,y+6,oParentDay)
			if otherspike != noone { 
				y += otherspike.bbox_top - (y + 10)
				if not place_meeting(x,y,oNope) 
					and state != WIN 
					and not godmode then instance_destroy();
			}
		}
	
		var near_solid = instance_place(x,y + 6, oSolid);
	
		if place_meeting(x, y + 8, oPlatGhost)
			and not place_meeting(x, y, oPlatGhost) then near_solid = instance_place(x, y + 6, oPlatGhost)

		if near_solid != noone {
			if not place_meeting(x, y + 6, oRamp) {
				grace_time = 2;
				y += near_solid.bbox_top - (y + 10)
			}
			
			if key > 0 
				and (place_meeting(x,y+6,oKeyDoor) 
					or place_meeting(x,y+6,oKeyDoorTall) 
					or place_meeting(x,y+6,oKeyDoorWide) 
					or place_meeting(x,y+6,oKeyDoorWide))
			{
				grace_time = 0;
				y += near_solid.bbox_top - (y + 10)
			} //dont jump but stick to the floor, this prevents a gamebreaker bug
		}
	
		var otherbroken = instance_place(x,y+6,oBrokenStone)
		if otherbroken != noone then instance_destroy(otherbroken);
	}
	#endregion
	
	// Change code
    if grace_time > 0 {
		if not neutral then scr_change();
	
		if last_plat != noone then instance_destroy(last_plat);
		grace_time = 0;
		vsp = -jumpspeed;
		image_index = 0;
		audio_play_sfx(snd_jump_player,false,-1.46,5);
	
		//Partículas
		if not godmode and not ghost {
			shake_gamepad(0.4, 2);
			repeat(random_range(3, 5)) {
				var dust = instance_create_layer(x, y + (sprite_height / 2), "Instances_2", oBigDust);
				dust.hsp = hsp / random_range(5, 10);
				dust.vsp = vsp / random_range(5, 10);
			}
		}
	}
}

// Jump state check 
if (!on_ground_var) {
    state = JUMP; 
}
#endregion

image_xscale=move

if has_collected_all_stars() {
	with (oPermaSpike) {solidvar=instance_create_layer(x,y,layer,oSolid) solidvar.x=x  solidvar.image_xscale=image_xscale solidvar.image_yscale=image_yscale solidvar.visible=false}
	//if winwait=60 {instance_create_layer(x,y,layer,oSuperStar)}
	state = WIN
	winwait -= 1

	if winwait<0 and room!=RoomMaker0
	{
		if !instance_exists(oTransition)
		{
			audio_play_sfx(sndStgClear,false,-14.4,0)
			
			if changecount=0 {changecount=1}
			if instance_exists(oBird) //stage is only half completed (50% completed)
			{
				var levelminusoom=string_replace(room_get_name(room),"Room","r")
				var loadvalue= variable_struct_get(oSaveManager.struct_main,levelminusoom) //0 =  not complete, >0.5 & <1.0 without bird, >1.0 complete
				
				if loadvalue=0 
				{
					variable_struct_set(oSaveManager.struct_main,levelminusoom,"0.5099")
					oSaveManager.save=true
				}
			}
			else //stage is completed
			{
				
				if changecount>99 {changecount=99}
				if changecount<10 {var jumpstr="00"+string(real(changecount))} else {var jumpstr="0"+string(real(changecount))}
				
				var levelminusoom=string_replace(room_get_name(room),"Room","r")
				var newscore="1.0"+jumpstr
				var oldscore=variable_struct_get(oSaveManager.struct_main,levelminusoom)
			
				if real(newscore)<(oldscore) or oldscore<1.0001 //less jumps= better
				{
					variable_struct_set(oSaveManager.struct_main,levelminusoom,newscore)
				}
				oSaveManager.save=true
			}
			
			//go to next room
				
			if instance_exists(oTimeAttack) {oTimeAttack.hearts+=2} 
			var trans=instance_create_layer(0,0,layer,oTransition)
			var level_index=oCamera.levelnumb
			var level_next= level_index+1
		
			trans.target_room=asset_get_index(string_insert(level_next,"Room",5))
			
			if (level_index+1) mod 5 = 0 {trans.target_room=Room100}//se for 5,10,15,20... vai pra HUB
			if level_index>=50 and level_index<60 {trans.target_room=Room100} //secret rooms
			if level_index=63 {trans.target_room=Room100}	//final roms
		}
	}
} 

/*
if night=true
{
	switch (state)
	{
	case IDLE :sprite_index=PlayerIdleNight  break;
	case RUN  :sprite_index=PlayerRunNight  break;
	case JUMP : if place_meeting(x,y,oLadderParent) and key_jump=true{sprite_index=PlayerClimbNight} else {sprite_index=PlayerJumpNight }	 break;
	case WIN  :sprite_index=PlayerHappyNight	 break;
	}

}
else
*/

// Player animation speed
if global.settings.gamespd != 100 {
	image_speed=global.settings.gamespd/100
} else {
	image_speed=1	
}

// Player idle animation timer
idletime += 0.01;

if idletime == 20 {
	image_index = 0;
} 

// Player animation switching
switch (state) {
	case IDLE: 
		if idletime >= 20 {
			sprite_index = PlayerSit;
		} else {
			sprite_index = PlayerIdle;
		}
		v_fric = 0.25;
		break;
		
	case RUN:
		sprite_index = PlayerRun;
		v_fric = 0.25;
		idletime = 0;
		break;
		
	case JUMP:
		idletime = 0;
		if on_ladder {
			sprite_index = PlayerClimb;
		} else {
			sprite_index = PlayerJump;
		}
		break;
		
	case WIN:
		sprite_index = PlayerHappy;
		break;
}

if pick > 0 {
	sprite_index = PlayerPickGrass;
	pick -= 1;
}

if !place_meeting(x,y,oNope)
{
if place_meeting(x+1,y+1,oParentDay) and vsp>-1.75  {if night=true{if state!=WIN and godmode=false {instance_destroy()}}}
if place_meeting(x-1,y-2,oParentDay) {if night=true {if state!=WIN and godmode=false {instance_destroy()}}}
if place_meeting(x-1,y+1,oParentDay)and vsp>-1.75   {if night=true{if state!=WIN and godmode=false {instance_destroy()}}}
if place_meeting(x+1,y-2,oParentDay) {if night=true {if state!=WIN and godmode=false {instance_destroy()}}}

if place_meeting(x+1,y+1,oParentNight) and vsp>-1.75  {if night=false{if state!=WIN and godmode=false {instance_destroy()}}}
if place_meeting(x-1,y-2,oParentNight) {if night=false{if state!=WIN and godmode=false {instance_destroy()}}}
if place_meeting(x-1,y+1,oParentNight) and vsp>-1.75  {if night=false{if state!=WIN and godmode=false {instance_destroy()}}}
if place_meeting(x+1,y-2,oParentNight) {if night=false{if state!=WIN and godmode=false {instance_destroy()}}}

}

if vsp < 0 {
	if not on_ladder and not audio_is_playing(snd_bump) and vsp < -0.75 {
		if place_meeting(x, y - 3, oSolid) 
			or (place_meeting(x, y - 3, oPlatGhostInv) 
			and not place_meeting(x, y, oPlatGhostInv))
		{
			var plat = instance_place(x, y - 3, oBrokenStone);
			
			instance_destroy(plat)
			if plat != noone then vsp = 0;
			shake_gamepad(1, 3);
			audio_play_sfx(snd_bump,false,-5,13)  
			repeat(3) {
				instance_create_layer(x, y-(sprite_height / 2),"Instances_2",oStarSmol)
			}
		} 
	}
}

// Sobe escada
if ds_exists(ladder_list, ds_type_list) {
	ds_list_clear(ladder_list);
	collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oLadderParent, false, true, ladder_list, true);
	if ds_list_size(ladder_list) > 0 and key_jump {
		on_ladder = true;
		var nearest_ladder = ds_list_find_value(ladder_list, 0);
	
		if ds_list_size(ladder_list) > 1
			or y > nearest_ladder.bbox_top - 4
			or place_meeting(x, y, oPlatGhost)
		{
			vsp = -0.75;
		} else {
			vsp = 0;
		}

		if key_left + key_right == 0 then
			x = approach(x, nearest_ladder.x + nearest_ladder.sprite_width / 2, 0.5);
	} else {
		on_ladder = false;
	}
}

if state=RUN
{
	if (floor(image_index)=3 or floor(image_index)=7) 
	{ 
		
		if !audio_is_playing(sndWalkGrass)
		{
			if place_meeting(x,y+1,oGrassDay) or place_meeting(x,y+1,oGrassNight)
			{audio_play_sfx(sndWalkGrass,false,-3.11,25)}
		}

		
		
		if !(audio_is_playing(sfx_cloud_01) or audio_is_playing(sfx_cloud_02) or audio_is_playing(sfx_cloud_03) or audio_is_playing(sfx_cloud_04))
		{
			if place_meeting(x,y+1,oCloudDay) or place_meeting(x,y+1,oCloudNight)
			{	
				var sfxwalkcloud=choose(sfx_cloud_01,sfx_cloud_02,sfx_cloud_03,sfx_cloud_04)
				audio_play_sfx(sfxwalkcloud,false,-9.2,5)
				
				var dust=instance_create_layer(x,y+(sprite_height/2),"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10)
				dust.vsp=vsp/random_range(5,10)	
				dust.image_index=1
			}
		}
		
		if !audio_is_playing(sndWalkStone) and !audio_is_playing(sndWalkGrass) and !audio_is_playing(sndWalkCloud)
		{
		if place_meeting(x,y+1,oSolid) or place_meeting(x,y+1,oPlatGhost) 
		{audio_play_sfx(sndWalkStone,false,-11.7,8)}
		}
		
		
	}
	}
	
if  place_meeting(x,y+1,oSnailGray) and vsp>-1.75
{
if state!=WIN and godmode=false {instance_destroy()}
}

if night=false
{
	if  place_meeting(x,y+1,oSnail) and vsp>-1.75
	{
	if state!=WIN and godmode=false {instance_destroy()}
	}
}
else
{
	if  place_meeting(x,y+1,oSnailNight) and vsp>-1.75
	{
	if state!=WIN and godmode=false {instance_destroy()}
	}
}

	if (place_meeting(x, y, oSolid))
	{if state!=WIN and godmode=false {instance_destroy() squash=true}}

if key_start=true and vsp=0 and hsp=0
{
	if !instance_exists(oPauseMenu)
	{
		if room!=RoomMenu and room!=RoomMenu2 and state!=WIN //and godmode=false
		{instance_create_layer(0,0,layer,oPauseMenu)}
	}
}

if flash>0 {flash-=0.25}

/*
if oCamera.arcade=32
{
if key_up=true or key_right=true or key_left=true or key_jump=true {idletime=0}
	
if idletime>120 {scr_restartgame()}

if gamepad_button_check(0,gp_start) and gamepad_button_check(0,gp_select) and gamepad_button_check(0,gp_shoulderlb) and gamepad_button_check(0,gp_shoulderrb) {scr_restartgame()}
}
*/




            with (instance_place(x, y, oRopeSegment))
                {phy_linear_velocity_x = other.hsp * 25; phy_linear_velocity_y = other.vsp * 25;}

#region Star, Spike and Bird Collisions


/////STAR COLLISION

colstar=instance_place(x,y,oStarColor)
if colstar!=noone
{
	if colstar.sprite_index!=sStarDaySpike
	{
	if colstar.neww=false
	{
		//audio_play_sfx(snd_coin,50,false)
		if star=0 {audio_play_sfx(sndStar1,false,-9.3,0)}
		if star=1 {audio_play_sfx(sndStar2,false,-9.3,0)}
		if star=2 {audio_play_sfx(sndStar3,false,-9.3,0)}
		if star=3  and global.settings.enable_sfx=true  {audio_play_sound(sndStar3,10,false,(power(10, -9.3/20)),0,1.05)}
	}

	instance_destroy(colstar)
	star+=1
	flash=1
	}
	else
	{
	if state!=WIN and godmode=false {instance_destroy()}
	}
	
}

var colstar=instance_place(x,y,oStar)
if colstar!=noone
{
	if colstar.visible=true
	{
		if colstar.neww=false
		{
			//audio_play_sfx(snd_coin,50,false)
		if star=0 {audio_play_sfx(sndStar1,false,-9.3,0)}
		if star=1 {audio_play_sfx(sndStar2,false,-9.3,0)}
		if star=2 {audio_play_sfx(sndStar3,false,-9.3,0)}
		if star=3  and global.settings.enable_sfx=true  {audio_play_sound(sndStar3,10,false,(power(10, -9.3/20)),0,1.05)}
		}
		if(colstar.prende_player){alarm[10]=1};
		instance_destroy(colstar)
		star+=1
		flash=1	
	}
}

/////SPIKE COLLISION
if instance_exists(oPermaSpike) and state!=WIN and godmode=false 
{
	if collision_rectangle(x-2,y-2,x+2,y+4,oPermaSpike,false,false)!=noone
	{
		if !place_meeting(x,y,oNope) {instance_destroy()}
	}
}

//////////MUSH COLLISION

if instance_exists(oMush)
{
	nearmush=instance_nearest(x,y,oMush); if nearmush.image_speed!=0 {nearmush=noone exit;}
	
	
	if nearmush.image_angle=0
	{
		if place_meeting(x,y,nearmush) and vsp>=0
		{
			
			if nearmush.gray=false {scr_change()}
			//oCamera.shake=1.25
			y=nearmush.y

			nearmush.image_speed=1
			grace_time=0
			if instance_exists(oMagicOrb) and nearmush.gray=false {oMagicOrb.vsp = -(jumpspeed+0.65)} else {vsp = -(jumpspeed+0.65)}
			image_index=0
			var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)
	

			//Partículas
			shake_gamepad(0.4,2)
			repeat(random_range(3,5))
				{
				var dust=instance_create_layer(x,y+(sprite_height/2),"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10)
				dust.vsp=vsp/random_range(5,10)
				}
			}
	}

	if nearmush.image_angle=-90 or nearmush.image_angle=270
	{
		if place_meeting(x,y,nearmush) and numb=0
		{
			if nearmush.gray=false {scr_change()}
			//oCamera.shake=1.25
			numb=10
			//y=nearmush.y
			vsp=-0.5

			nearmush.image_speed=1
			grace_time=0
			if instance_exists(oMagicOrb) and nearmush.gray=false {oMagicOrb.hsp = +jumpspeed} else {hsp = +jumpspeed}
			v_fric=0
			image_index=0
			var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)
	
	
			//Partículas
			shake_gamepad(0.4,2)
			repeat(random_range(3,5))
				{
				var dust=instance_create_layer(x-(sprite_width/2),y,"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10)
				dust.vsp=vsp/random_range(5,10)
				}
			}
	}
	
		if nearmush.image_angle=-270 or nearmush.image_angle=90
	{
		if place_meeting(x,y,nearmush) and numb=0
		{
			if nearmush.gray=false {scr_change()}
			//oCamera.shake=1.25
			numb=10
			//y=nearmush.y
			vsp=-0.5

			nearmush.image_speed=1
			grace_time=0
			if instance_exists(oMagicOrb) and nearmush.gray=false {oMagicOrb.hsp = -jumpspeed} else {hsp = -jumpspeed}
			
			v_fric=0
			image_index=0
			var sfxcogu=choose(snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04) audio_play_sfx(sfxcogu,false,-16,2)
	
	
			//Partículas
			shake_gamepad(0.4,2)
			repeat(random_range(3,5))
				{
				var dust=instance_create_layer(x-(sprite_width/2),y,"Instances_2",oBigDust)
				dust.hsp=hsp/random_range(5,10)
				dust.vsp=vsp/random_range(5,10)
				}
			}
	}
}
#endregion
