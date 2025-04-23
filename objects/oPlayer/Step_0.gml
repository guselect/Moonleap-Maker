var ghost = PlayerIdle == sGhost;

// Shake gamepad and make particles on landing.
if not was_on_ground and vsp > 0 and has_collided(0, 1)
{
	if not instance_exists(oTransition) {shake_gamepad(1,3)}
	repeat(irandom_range(3, 5)) {
		var dust = instance_create_layer(x, y + (sprite_height / 2), "Instances_2", oBigDust);
		dust.hsp = random_range(-0.5, 0.5) + (hsp / 5);
	}
}

was_on_ground = has_collided(0, 1);

if key_left {
	key_right = false
}

if mode == PLAYER_MODE.DIRECTION
and key_right + key_left == 1
and ((key_left and image_xscale == 1) 
    or (key_right and image_xscale == -1)
) then scr_change();

// RESET (suicide)
if not debug_mode
and state != PLAYER_STATE.WIN
and not instance_exists(oMenu)
and not instance_exists(oPauseMenu)
and not instance_exists(oIntro)
and not instance_exists(oTransition)
and not current_room_is([RoomMenu, RoomMenu2, RoomFinal, RoomCredits, RoomCreditsAlves, RoomProgress])
{
    if room == Room100
    and place_meeting(x, y, oSpecial5Trigger) 
    and instance_exists(oSpecial5)
    and key_reset { 
        oSpecial5.done = true;
        instance_destroy();
    } else if key_reset {
        instance_destroy();
    }
}



#region Movimentação + Pulo

// Wall cling to avoid accidental push-off
if ((!key_right && !key_left) || was_on_ground) {
    can_stick = true;
    sticking = false;
} else if (((key_right && key_left) || (key_left && key_right)) && can_stick && !was_on_ground) {
    alarm[0] = cling_time;
    sticking = true; 
    can_stick = false;       
}


if key_left or key_right or key_jump_pressed {
	alarm[11] = game_get_speed(gamespeed_fps) * 30;
}

if room == Room100 or instance_exists(oPauseMenu) {
	alarm[11] += 1;
}


// Horizontal movement
// Left 
if key_left and not key_right and not sticking {
    move = -1;
    state = PLAYER_STATE.RUN;
  
    if hsp > -v_max {
        hsp = approach(hsp, -v_max, v_ace);
    }

// Right
} else if key_right and not key_left and not sticking {
    move = 1;
    state = PLAYER_STATE.RUN;
    
    if hsp < v_max { 
        hsp = approach(hsp, v_max, v_ace);
    }
}

image_angle = 0;

// Friction
if not key_right and not key_left {
    hsp = approach(hsp, 0, v_fric);
    state = PLAYER_STATE.IDLE;
}

// Vertical movement
if was_on_ground {
	grace_time = grace_time_frames;
	last_plat = instance_place(x, y + 6, oBrokenStone);
} else {
	if vsp > -1 and vsp < 1 {
		grav = 0.09;
	} else {
		grav = 0.125;
	}

    //gravidade limitada por 4 de vsp
	vsp = approach(vsp, 3 + (key_down * 2), grav);
	grace_time = approach(grace_time, 0, 1) + ghost;
}

// Jump
if key_jump_pressed 
	and not place_meeting(x,y,oLadderParent)
	and not key_down 
	and not has_collided(0, -2)
{
	#region Stick to the floor
	if vsp > -1 {	
		if not night {
			var otherspike = instance_place(x, y + 6, oParentNight);
			if otherspike != noone {
				y += otherspike.bbox_top - (y + 10); //é 10 porque sprite_height/2=9
				
				if not place_meeting(x,y,oNope) 
					and state != PLAYER_STATE.WIN 
					and not godmode then instance_destroy();
			} 
		} else {
			var otherspike = instance_place(x,y+6,oParentDay)
			if otherspike != noone { 
				y += otherspike.bbox_top - (y + 10)
				if not place_meeting(x,y,oNope) 
					and state != PLAYER_STATE.WIN 
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
		if mode == PLAYER_MODE.LEAP then
            scr_change();
	
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
if not has_collided(0, 1) {
    state = PLAYER_STATE.JUMP; 
}
#endregion

if has_collected_all_stars() {
	with (oPermaSpike) {
		var solidvar = instance_create_layer(x, y, layer, oSolid);
		solidvar.x = x;
		solidvar.image_xscale = image_xscale;
		solidvar.image_yscale = image_yscale;
		solidvar.visible = false;
	}

	state = PLAYER_STATE.WIN;
	winwait -= 1;

	if winwait < 0 and room != RoomMaker0 and not instance_exists(oTransition) {
		audio_play_sfx(sndStgClear,false,-14.4,0)
			
		if changecount == 0 then changecount = 1;
		
		//stage is only half completed (50% completed)
		if instance_exists(oBird) {
			var levelminusoom = string_replace(room_get_name(room), "Room", "r");
			
			//0 = not complete; >0.5 & <1.0 without bird; >1.0 complete
			var loadvalue = variable_struct_get(oSaveManager.struct_main, levelminusoom) 
				
			if loadvalue == 0 {
				variable_struct_set(oSaveManager.struct_main, levelminusoom, "0.5099");
				oSaveManager.save = true;
			}
		} else { //stage is completed 
			if changecount > 99 {
				changecount = 99;
			}
			
			var jumpstr = "00" + string(real(changecount));
			if changecount >= 10 {
				jumpstr = "0" + string(real(changecount));
			}
				
			var levelminusoom = string_replace(room_get_name(room), "Room", "r");
			var newscore = "1.0" + jumpstr;
			var oldscore = variable_struct_get(oSaveManager.struct_main, levelminusoom);
			
			if real(newscore) < (oldscore) or oldscore < 1.0001 //less jumps= better
			{
				variable_struct_set(oSaveManager.struct_main,levelminusoom,newscore)
			}
			oSaveManager.save = true;
		}
			
		// Go to next room
				
		if instance_exists(oTimeAttack) {
			oTimeAttack.hearts += 2
		} 
		var trans = instance_create_layer(0, 0, layer, oTransition);
		var level_index = oCamera.levelnumb;
		var level_next = level_index + 1;
		
		trans.target_room = asset_get_index(string_insert(level_next, "Room", 5));
		
		// Se for 5, 10, 15, 20... vai pra HUB
		if (level_index + 1) mod 5 == 0 {
			trans.target_room = Room100;
		}
		// Secret rooms
		if level_index >= 50 and level_index < 60 {
			trans.target_room = Room100;
		} 
		// Final rooms
		if level_index == 63 {
			trans.target_room = Room100;
		}	
	}
} 

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
	case PLAYER_STATE.IDLE: 
		if idletime >= 20 {
			sprite_index = PlayerSit;
		} else {
			sprite_index = PlayerIdle;
		}
		v_fric = 0.25;
		break;
		
	case PLAYER_STATE.RUN:
		sprite_index = PlayerRun;
		v_fric = 0.25;
		idletime = 0;
		break;
		
	case PLAYER_STATE.JUMP:
		idletime = 0;
		if on_ladder {
			sprite_index = PlayerClimb;
		} else {
			sprite_index = PlayerJump;
		}
		break;
		
	case PLAYER_STATE.WIN:
		sprite_index = PlayerHappy;
		break;
}

if pick > 0 {
	sprite_index = PlayerPickGrass;
	pick -= 1;
}

// Day/Night objects' spikes collision
if not place_meeting(x, y, oNope)
and not godmode 
and state != PLAYER_STATE.WIN {
    if night {
        if (place_meeting(x + 1, y + 1, oParentDay) and vsp > -1.75)
        or (place_meeting(x - 1, y - 2, oParentDay))
        or (place_meeting(x - 1, y + 1, oParentDay) and vsp > -1.75)
        or (place_meeting(x + 1, y - 2, oParentDay)) {
            instance_destroy();
        }
    } else {
        if (place_meeting(x + 1, y + 1, oParentNight) and vsp > -1.75)
        or (place_meeting(x - 1, y - 2, oParentNight))
        or (place_meeting(x - 1, y + 1, oParentNight) and vsp > -1.75)
        or (place_meeting(x + 1, y - 2, oParentNight)) { 
            instance_destroy()
        }
    }
}

// When the player collides its head on solid while jumping...
if vsp < 0 
and not on_ladder
and not audio_is_playing(snd_bump)
and vsp < -0.75 
and has_collided(0, -3) {
	// Break stone if is above player
	var plat = instance_place(x, y - 3, oBrokenStone);
	instance_destroy(plat)
			
	// Then make it stop vertically
	if plat != noone then vsp = 0;
			
	shake_gamepad(1, 3);
	audio_play_sfx(snd_bump, false, -5, 13);
			
	// Create particles above the player
	repeat(3) {
		instance_create_layer(x, y - sprite_height / 2,"Instances_2",oStarSmol);
	}
}

// Climb ladder
if ds_exists(ladder_list, ds_type_list) {
	ds_list_clear(ladder_list);
	var ladder_count = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oLadderParent, false, true, ladder_list, true);
	if ladder_count > 0 and key_jump {
		on_ladder = true;
		var nearest_ladder = ds_list_find_value(ladder_list, 0);
	
		if ladder_count > 1
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

// Footsteps sounds
if state == PLAYER_STATE.RUN and (floor(image_index) == 3 or floor(image_index) == 7) { 
	// Walking on grass/flowers
	if not audio_is_playing(sndWalkGrass)
	and (place_meeting(x, y + 1, oGrassDay) 
		or place_meeting(x, y + 1, oGrassNight)
		or place_meeting(x, y + 1, oFlowerDay)
		or place_meeting(x, y + 1, oFlowerNight)
		or (instance_exists(oLevelMaker) 
			and (oLevelMaker.selected_style == LEVEL_STYLE.GRASS
				or oLevelMaker.selected_style == LEVEL_STYLE.FLOWERS
			) and (place_meeting(x, y + 1, oSolidDay) 
				or place_meeting(x, y + 1, oSolidNight)
			)
		)
	) {
		audio_play_sfx(sndWalkGrass, false, -3.11, 25);
	}

	// Walking on ground
	if not (audio_is_playing(sfx_cloud_01) 
		or audio_is_playing(sfx_cloud_02) 
		or audio_is_playing(sfx_cloud_03) 
		or audio_is_playing(sfx_cloud_04)
	) and (place_meeting(x,y+1,oCloudDay) 
		or place_meeting(x,y+1,oCloudNight)
		or (instance_exists(oLevelMaker) 
			and oLevelMaker.selected_style == LEVEL_STYLE.CLOUDS 
			and (place_meeting(x, y + 1, oSolidDay) 
				or place_meeting(x, y + 1, oSolidNight)
			)
		)
	) {	
		var sfxwalkcloud = choose(sfx_cloud_01, sfx_cloud_02, sfx_cloud_03, sfx_cloud_04);
		audio_play_sfx(sfxwalkcloud, false, -9.2, 5);
				
		var dust = instance_create_layer(x, y + (sprite_height / 2), "Instances_2", oBigDust);
		dust.hsp = hsp / random_range(5, 10);
		dust.vsp = vsp / random_range(5, 10);
		dust.image_index = 1;
	}

    // Walking on stone
	if not audio_is_playing(sndWalkStone)
	and not audio_is_playing(sndWalkGrass)
	and not audio_is_playing(sndWalkCloud)
	and (place_meeting(x, y + 1, oSolid) 
		or place_meeting(x ,y + 1, oPlatGhost)
	) {  
		audio_play_sfx(sndWalkStone, false, -11.7, 8);
	}
}

// When player is stepping on snail's spike
if (place_meeting(x, y + 1, oSnailGray)
	or (place_meeting(x, y + 1, oSnail) and not night)
	or (place_meeting(x, y + 1, oSnailNight) and night)
) and vsp > -1.75
and state != PLAYER_STATE.WIN 
and not godmode {
	instance_destroy();
}

// When player is entering the wall/solid
if place_meeting(x, y, oSolid)
and state != PLAYER_STATE.WIN 
and not godmode {
	instance_destroy(); 
	squash = true;
}

// On press to pause the game.
if key_start
and vsp == 0 
and hsp == 0
and not instance_exists(oPauseMenu)
and room != RoomMenu 
and room != RoomMenu2 
and state != PLAYER_STATE.WIN {
	instance_create_layer(0, 0, layer, oPauseMenu);
}

if flash > 0 {
	flash -= 0.25;
}

// Rope swinging
with (instance_place(x, y, oRopeSegment)) {
	phy_linear_velocity_x = other.hsp * 25;
	phy_linear_velocity_y = other.vsp * 25;
}

// ----- STAR COLLISION -----

var colstar = instance_place(x, y, oStarColor);
if colstar != noone
and colstar.sprite_index != sStarDaySpike {
	if colstar.sprite_index == sStarDaySpike 
	and state != PLAYER_STATE.WIN
	and not godmode {
		instance_destroy();
	} else {
		if not colstar.neww {
			//audio_play_sfx(snd_coin,50,false)place_meeting(x + 1, y - 2, oParentNight)
			if stars_collected == 0 then audio_play_sfx(sndStar1, false, -9.3, 0);
			if stars_collected == 1 then audio_play_sfx(sndStar2, false, -9.3, 0);
			if stars_collected == 2 then audio_play_sfx(sndStar3, false, -9.3, 0);
			if stars_collected == 3 and global.settings.enable_sfx then 
                audio_play_sound(sndStar3, 10, false, power(10, -9.3 / 20), 0, 1.05);
		}

		instance_destroy(colstar);
		stars_collected += 1;
		flash = 1;
	}
}

colstar = instance_place(x, y, oStar);
if colstar != noone and colstar.visible {
	if not colstar.neww {
		if stars_collected == 0 then audio_play_sfx(sndStar1, false, -9.3, 0);
		if stars_collected == 1 then audio_play_sfx(sndStar2, false, -9.3, 0);
		if stars_collected == 2 then audio_play_sfx(sndStar3, false, -9.3, 0);
		if stars_collected == 3 and global.settings.enable_sfx then
			audio_play_sound(sndStar3, 10, false, power(10, -9.3 / 20), 0, 1.05);
	}
	if colstar.prende_player {
		alarm[10] = 1;
	};
		
	instance_destroy(colstar);
	stars_collected += 1;
	flash = 1;
}

/// ----- SPIKE COLLISION -----
if instance_exists(oPermaSpike)
and state != PLAYER_STATE.WIN
and not godmode
and collision_rectangle(x - 2, y - 2, x + 2, y + 4, oPermaSpike, false, false) != noone
and not place_meeting(x, y, oNope) {
	instance_destroy()
}

/// ----- MUSHROOM COLLISION -----
if instance_exists(oMush) {
	var nearmush = instance_nearest(x,y,oMush);
	
	if nearmush.image_speed != 0 {
		nearmush = noone;
		exit;
	}

	if nearmush.image_angle == 0 
    and place_meeting(x, y, nearmush)
    and vsp >= 0 {
		if not nearmush.gray {
			scr_change();
		}
		
		y = nearmush.y;
		nearmush.image_speed = 1;
		grace_time = 0;
		
		if instance_exists(oMagicOrb)
        and not nearmush.gray {
			oMagicOrb.vsp = -(jumpspeed + 0.65)
		} else {
			vsp = -(jumpspeed + 0.65)
		}
		
		image_index = 0;
		
		var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
		audio_play_sfx(sfxcogu, false, -16, 2);
	
		//Partículas
		shake_gamepad(0.4, 2);
		repeat(random_range(3, 5)) {
			var dust = instance_create_layer(x, y + (sprite_height / 2), "Instances_2", oBigDust);
			dust.hsp = hsp / random_range(5,10);
			dust.vsp = vsp / random_range(5,10);
		}
	}

	if (nearmush.image_angle == -90 or nearmush.image_angle == 270) 
	and place_meeting(x,y,nearmush)
    and numb == 0 {
		if not nearmush.gray {
			scr_change();
		}
		numb = 10;
		vsp = -0.5;

		nearmush.image_speed = 1;
		grace_time = 0;
		if instance_exists(oMagicOrb) and not nearmush.gray {
			oMagicOrb.hsp = +jumpspeed
		} else {
			hsp = +jumpspeed
		}
		
		v_fric = 0;
		image_index = 0;
		var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
		audio_play_sfx(sfxcogu, false, -16, 2);

		//Partículas
		shake_gamepad(0.4, 2);
		repeat(random_range(3, 5)) {
			var dust = instance_create_layer(x - (sprite_width / 2), y, "Instances_2", oBigDust);
			dust.hsp = hsp / random_range(5, 10);
			dust.vsp = vsp / random_range(5, 10);
		}
	}
	
	if (nearmush.image_angle == -270 or nearmush.image_angle == 90)
	and place_meeting(x,y,nearmush)
    and numb == 0 {
		if not nearmush.gray {
			scr_change()
		}
		numb = 10;
		vsp = -0.5;

		nearmush.image_speed = 1;
		grace_time = 0;
		
		if instance_exists(oMagicOrb) 
		and not nearmush.gray {
			oMagicOrb.hsp = -jumpspeed;
		} else {
			hsp = -jumpspeed;
		}
			
		v_fric = 0;
		image_index = 0;
		var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04) ;
		audio_play_sfx(sfxcogu, false, -16, 2);
		
		//Partículas
		shake_gamepad(0.4, 2);
		repeat(random_range(3,5)) {
			var dust = instance_create_layer(x-(sprite_width/2),y,"Instances_2",oBigDust);
			
			dust.hsp = hsp / random_range(5, 10);
			dust.vsp = vsp / random_range(5, 10);
		}
	}

	if (abs(nearmush.image_angle) == 180)
	and place_meeting(x,y,nearmush)
    and vsp < 0 {
		if not nearmush.gray {
			scr_change();
		}
		
		y = nearmush.y;
		nearmush.image_speed = 1;
		grace_time = 0;
		
		if instance_exists(oMagicOrb)
        and not nearmush.gray {
			oMagicOrb.vsp = (jumpspeed + 0.65)
		} else {
			vsp = (jumpspeed + 0.65)
		}
		
		image_index = 0;
		
		var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
		audio_play_sfx(sfxcogu, false, -16, 2);
	
		//Partículas
		shake_gamepad(0.4, 2);
		repeat(random_range(3, 5)) {
			var dust = instance_create_layer(x, y + (sprite_height / 2), "Instances_2", oBigDust);
			dust.hsp = hsp / random_range(5,10);
			dust.vsp = vsp / random_range(5,10);
		}
	}
}
