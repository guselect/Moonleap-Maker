// ------------------------------------ NOTA IMPORTANTE ------------------------------------
//
// Nas fases, o jogador deve ser instanciado depois que as estrelas forem instanciadas.
// Havia um problema no editor de níveis onde algumas estrelas eram instanciadas depois
// do oPlayer, fazendo com que estas não sejam contabilizadas.
// O ideal é que o oPlayer seja criado na Room depois que as estrelas já forem criadas
// para que a contagem de estrelas seja feita corretamente.
//
// -----------------------------------------------------------------------------------------

enum PLAYER_MODE { LEAP, DIRECTION, NEUTRAL }

scr_inputcreate()
changecount = 0;
dsquash = false;
dwater = false;
shake = 0;
white = 0;
gowhite = false; // used to fade out on portal
key = 0;

cape = true;
birdstuck = false;
godmode = false;
neutral = false;
jump_trigger = false;

trueblack = false;

if instance_exists(oLevelMaker) {
	switch(oLevelMaker.selected_style) {
		case LEVEL_STYLE.FLOWERS:
		case LEVEL_STYLE.SPACE:
		case LEVEL_STYLE.DUNGEON:
			trueblack = true; break;
	}
} else if instance_exists(oSpaceDay)
or instance_exists(oFlowerDay)
or instance_exists(oDunDay) {
	trueblack = true;
}

if instance_exists(oNeutralFlag) {
    neutral = true;
}

levelnumb = 0;

// Timer to perform the sit animation.
idletime = 0;
idletime_max = 20;

// Timer to perform the skin changing.
skin_change_timer = 0;
skin_change_timer_max = 30;

night = false;

on_ladder = false;

last_plat = 0;
winwait = 60;
grace_time = 0;
grace_time_frames = 10;

hsp = 0;
vsp = 0;
jumpspeed = 2.25;
v_max = 1;
v_ace = 0.25; 
v_fric = 0.25;
grav = 0.125;

numb = 0;

cling_time = 4.0;
move = 1;
sticking = true; 
can_stick = false;
flash = 0;
squash = false;
ghost = false;

was_on_ground = has_collided(0, 1);

cx = 0;
cy = 0;

sticking = false

mode = PLAYER_MODE.LEAP;

roomw = room_width;
roomh = room_height;

has_collected_bird = false;
stars_collected = 0;
stars_to_collect = 0;

if not instance_exists(oStar) {
	var hidden_star = instance_create_layer(roomw, roomh, layer, oStar);
	hidden_star.visible = false;
}

has_collected_all_stars = function() {
	return stars_collected == stars_to_collect;
}

stars_to_collect = instance_number(oStar);

// If level is secret bird level
if room == Room58 { 
	stars_to_collect = 1;
}

glow = false;

ladder_list = ds_list_create();

alarm[11] = game_get_speed(gamespeed_fps) * 30;

if instance_exists(oSaveManager) and room != RoomIntro0 {
	scr_checkskin();
} else {
	PlayerIdle=			sPlayerIdle
	PlayerRun=			sPlayerRun
	PlayerJump=			sPlayerJump
	PlayerSit=			sPlayerSit
	PlayerClimb=		sPlayerClimb
	PlayerDead=			sPlayerDead
	PlayerEnding=		sPlayerEnding
	PlayerEndingFlash=	sPlayerEndingFlash
	PlayerHappy=		sPlayerHappy	
}

if room == RoomFinal {
    night = oCamera.endnight
}

mask_index = sPlayerIdle;
visible = not instance_exists(oRoomTransition);

// -------------------------------------
// PLAYER STATES CONFIGURATION
// -------------------------------------

state = new SnowState("idle");
// Idle state
state.add("idle", {
	step: function() {
		sprite_index = PlayerIdle;
		v_fric = 0.25;
		set_idle_timer();

		check_change_by_direction();
		set_movement_and_gravity();
		set_jump();
		set_animation_speed();
		set_game_paused();
		set_rope_swinging();
		
		check_destroy_itself();

		check_ceiling_collision();
		check_ladder_collision();
		check_day_night_spikes_collision();
		check_snail_spike_collision();
		check_wall_squash_collision();
		check_star_collision();
		check_perma_spike_collision();
		check_mushroom_collision();
	},
	leave: function() {
		idletime = 0;
	}
});

// Run state
state.add("run", {
	step: function() {
		sprite_index = PlayerRun;
		v_fric = 0.25;
		check_change_by_direction();
		
		set_movement_and_gravity();
		set_jump();
		set_animation_speed();
		set_footstep_sound();
		set_rope_swinging();
        
		check_destroy_itself();

		check_ceiling_collision();
		check_ladder_collision();
		check_day_night_spikes_collision();
		check_snail_spike_collision();
		check_wall_squash_collision();
		check_star_collision();
		check_perma_spike_collision();
		check_mushroom_collision();
	}
});

// Jump state
state.add("jump", {
	step: function() {
		check_change_by_direction();
		set_movement_and_gravity();
		set_jump();
		set_animation_speed();
		set_rope_swinging();

		check_destroy_itself();

		sprite_index = on_ladder ? PlayerClimb : PlayerJump;

		check_ceiling_collision();
		check_ladder_collision();
		check_day_night_spikes_collision();
		check_snail_spike_collision();
		check_wall_squash_collision();
		check_star_collision();
		check_perma_spike_collision();
		check_mushroom_collision();  
	}
});

// Win state
state.add("win", {
	enter: function() {
		with (oPermaSpike) {
		   var _solid = instance_create_layer(x, y, layer, oSolid);
		   _solid.x = x;
		   _solid.image_xscale = image_xscale;
		   _solid.image_yscale = image_yscale;
		   _solid.visible = false;
		}
	},
	step: function() {
		sprite_index = PlayerHappy;
		set_movement_and_gravity();
		set_animation_speed();
		set_game_paused();
		set_rope_swinging();

		perform_win();

		check_ceiling_collision();
		check_ladder_collision();
		check_day_night_spikes_collision();
		check_snail_spike_collision();
		check_wall_squash_collision();
		check_star_collision();
		check_perma_spike_collision();
		check_mushroom_collision();
	}
});

// ---- State transitions ----
// Transitions help making one or more states changing to another even easier.
// They will be executed if their function's returned value is true.

state.add_transition("t_tr", ["idle", "jump"], "run", function() {
	return has_collided(0, 1) and (key_right or key_left)
});

state.add_transition("t_tr", ["idle", "run"], "jump", function() {
	return not has_collided(0, 1);
});

state.add_transition("t_tr", ["run", "jump"], "idle", function() {
	return has_collided(0, 1) and not (key_right or key_left);
});

state.add_transition("t_tr", ["idle", "run", "jump"], "win", function() {
	return stars_collected == stars_to_collect;
});

// -------------------------------------
// PLAYER METHOD FUNCTIONS
// -------------------------------------

set_idle_timer = function() {
	idletime = min(idletime + 0.01, idletime_max);
	if idletime >= idletime_max {
		sprite_index = PlayerSit;
	}
}

set_movement_and_gravity = function() {
	// Wall cling to avoid accidental push-off
	if ((not key_right and not key_left) or was_on_ground) {
	   can_stick = true;
	   sticking = false;
	} else if (((key_right and key_left) or (key_left and key_right)) and can_stick and not was_on_ground) {
	   alarm[0] = cling_time;
	   sticking = true; 
	   can_stick = false;       
	}
    
    
	if key_left or key_right or key_jump_pressed {
		alarm[11] = game_get_speed(gamespeed_fps) * 30;
	}
    
	if is_at_hub() or instance_exists(oPauseMenu) {
		alarm[11] += 1;
	}
    
    
	// Horizontal movement
	// Left 
	if key_left and not key_right and not sticking {
	   move = -1;
	   if hsp > -v_max {
	      hsp = approach(hsp, -v_max, v_ace);
	   }
    
	// Right
	} else if key_right and not key_left and not sticking {
	   move = 1;
		if hsp < v_max { 
	      hsp = approach(hsp, v_max, v_ace);
	   }
	}
    
	image_angle = 0;
    
	// Friction
	if not key_right and not key_left {
	   hsp = approach(hsp, 0, v_fric);
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
	
	if key_right + key_left == 2 {
		key_right = 0;
		key_left = 0;
	}
}

set_godmode_toggling = function() {
    if not debug_mode
    or not oCamera.debug
    or not key_reset {
        return;
    }

    godmode = not godmode;
    oCamera.show_debug = godmode;
}

set_godmode_movement = function() {
    if not godmode then return;

    grav = 0;
    if key_jump or key_up then vsp = -4;
    if key_down then vsp = 2;
    if key_left then hsp = -3;
    if key_right then hsp = 3;
}

set_jump = function() {
	if not key_jump_pressed
	or key_down
	or place_meeting(x, y, oLadderParent)
	or has_collided(0, -2) {
	   return;
	}

	if vsp > -1 {
	   // Go up a bit higher from oParentDay & oParentNight
	   // to not collide with spikes while jumping and changing.
	   // day/night state.
	   if not night {
	      var _parent_night = instance_place(x, y + 6, oParentNight);
	      if _parent_night != noone {
	            y += _parent_night.bbox_top - (y + 10); //é 10 porque sprite_height/2=9
                
	            if not place_meeting(x, y, oNope) 
	            and not state.state_is("win")
	            and not godmode {
	               instance_destroy();
	            } 
	      }
	   } else {
	      var _parent_day = instance_place(x, y + 6, oParentDay);
	      if _parent_day != noone { 
	            y += _parent_day.bbox_top - (y + 10);

	            if not place_meeting(x, y, oNope) 
	            and not state.state_is("win")
	            and not godmode {
	               instance_destroy();
	            } 
	      }
	   }
    
	   var _solid = instance_place(x, y + 6, oSolid);
    
	   if place_meeting(x, y + 8, oPlatGhost) and not place_meeting(x, y, oPlatGhost) {
	      _solid = instance_place(x, y + 6, oPlatGhost);
	   }

	   if _solid != noone {
	      if not place_meeting(x, y + 6, oRamp) {
	            grace_time = 2;
	            y += _solid.bbox_top - (y + 10)
	      }
            
	      // Don't jump but stick to the floor, this prevents a gamebreaker bug
	      if key > 0 and (place_meeting(x,y + 6, oKeyDoor) 
	            or place_meeting(x,y + 6,oKeyDoorTall) 
	            or place_meeting(x,y + 6,oKeyDoorWide) 
	            or place_meeting(x,y + 6,oKeyDoorWide)) {
	            grace_time = 0;
	            y += _solid.bbox_top - (y + 10);
	      } 
	   }

	   var _broken_stone_below = instance_place(x, y + 6, oBrokenStone);

	   if _broken_stone_below != noone then 
	      instance_destroy(_broken_stone_below);
	}
    
    
	if grace_time <= 0 then return;

	// Change day/night state
	if mode == PLAYER_MODE.LEAP then
	   scr_change();

	if last_plat != noone then
	   instance_destroy(last_plat);

	grace_time = 0;
	vsp = -jumpspeed;
	image_index = 0;
	audio_play_sfx(snd_jump_player, false, -1.46, 5);

	// Spawn cloud particles on jump
	if godmode or ghost then return;

	shake_gamepad(0.4, 2);
	repeat(irandom_range(3, 5)) {
	   var dust = instance_create_layer(x, y + (sprite_height / 2), "Instances_2", oBigDust);

	   dust.hsp = hsp / random_range(5, 10);
	   dust.vsp = vsp / random_range(5, 10);
	}
	 
	// Spawn leaf particles on jump from grass ground.
	if place_meeting(x, y + 1, oGrassDay)
	or (instance_exists(oLevelMaker) and oLevelMaker.selected_style == LEVEL_STYLE.GRASS and place_meeting(x, y + 1, oSolidDay)) {
		repeat (irandom_range(1, 2)) {
			instance_create_layer(x, y + (sprite_height / 3), "Instances_2", oLeafDay);
		}
	}
		
	if place_meeting(x, y + 1, oGrassNight)
	or (instance_exists(oLevelMaker) and oLevelMaker.selected_style == LEVEL_STYLE.GRASS and place_meeting(x, y + 1, oSolidNight)) {
		repeat (irandom_range(1, 2)) {
			instance_create_layer(x, y + (sprite_height / 3), "Instances_2", oLeafNight);
		}
	}
}

set_game_paused = function() {
	if not key_start
	or vsp != 0 
	or hsp != 0
	or instance_exists(oPauseMenu)
	or room_is([RoomMenu, RoomMenu2]) {
		return;
	}

	instance_create_layer(0, 0, layer, oPauseMenu);
}

set_footstep_sound = function() {
	if floor(image_index) != 3 and floor(image_index) != 7 {
		return;
	}

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

	// Walking on clouds
	if not audio_is_playing_any([sfx_cloud_01, sfx_cloud_02, sfx_cloud_03, sfx_cloud_04]) 
	and (place_meeting(x, y + 1,oCloudDay) 
	   or place_meeting(x, y + 1,oCloudNight)
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
	if not audio_is_playing_any([sndWalkStone, sndWalkGrass, sndWalkCloud])
	and (place_meeting(x, y + 1, oSolid) 
	   or place_meeting(x ,y + 1, oPlatGhost)
	) {  
	   audio_play_sfx(sndWalkStone, false, -11.7, 8);
	}
}

set_rope_swinging = function() {
	with (instance_place(x, y, oRopeSegment)) {
		phy_linear_velocity_x = other.hsp * 25;
		phy_linear_velocity_y = other.vsp * 25;
	}
}

check_destroy_itself = function() {
	if debug_mode
	or state.state_is("win")
	or instance_exists_any([oMenu, oPauseMenu, oIntro, oTransition])
	or room_is([RoomMenu, RoomMenu2, RoomFinal, RoomCredits, RoomCreditsAlves, RoomProgress]) {
	   return;
	}

	if is_at_hub()
	and place_meeting(x, y, oSpecial5Trigger) 
	and instance_exists(oSpecial5)
	and key_reset { 
	   oSpecial5.done = true;
	   instance_destroy();
	   return;
	} else if key_reset and not is_at_hub() {
	   instance_destroy();
	}
}

set_animation_speed = function() {
	image_speed = global.settings.gamespd / 100;
}

set_skin_changing = function() {
	//not pressing, holding, star only exists ingame
	if not key_down_notpressed or not was_on_ground {
		skin_change_timer = 0;
		return;
	}
	
	skin_change_timer = min(skin_change_timer + 1, skin_change_timer_max + 1);
    
	if skin_change_timer == skin_change_timer_max {
		idletime = 0;
		scr_changeskin();
	}
}

check_change_by_direction = function() {
    if mode != PLAYER_MODE.DIRECTION
    or key_right + key_left != 1
    or not ((key_left and image_xscale == 1) or (key_right and image_xscale == -1)) {
        return;
    }

    scr_change();
}

perform_win = function() {
	 winwait -= 1;

    if winwait >= 0
    or room == RoomMaker0
    or instance_exists(oTransition) {
        return;
    }

    audio_play_sfx(sndStgClear, false, -14.4, 0);
        
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
        
        //less jumps= better
        if real(newscore) < oldscore or oldscore < 1.0001 {
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

check_controls_disabling = function() {
    if not state.state_is("win")
    and not instance_exists(oPauseMenu) 
    and numb <= 0
    and not (instance_exists(oTransition) and (oTransition.wait != 0 or is_at_hub())) {
    	return;
    }

    key_right = 0;
    key_left = 0;
    key_jump_pressed = 0;
    key_jump = 0;
    key_start = 0;
}

check_on_landing = function() {
    if was_on_ground 
    or vsp <= 0 
    or not has_collided(0, 1) {
        return;
    }

    if not instance_exists(oTransition) {
        shake_gamepad(1, 3);
    }

    repeat(irandom_range(3, 5)) {
        var dust = instance_create_layer(x, y + (sprite_height / 2), "Instances_2", oBigDust);

        dust.hsp = random_range(-0.5, 0.5) + (hsp / 5);
    }
}

check_day_night_spikes_collision = function() {
    if place_meeting(x, y, oNope)
    or godmode 
    or state.state_is("win") {
        return;
    }

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

check_ceiling_collision = function() {
    if vsp >= 0 
    or on_ladder
    or audio_is_playing(snd_bump)
    or vsp >= -0.75 
    or not has_collided(0, -3) {
        return;	
    }

    var _broken_stone = instance_place(x, y - 3, oBrokenStone);

    instance_destroy(_broken_stone);
    if _broken_stone != noone then vsp = 0;
            
    shake_gamepad(1, 3);
    audio_play_sfx(snd_bump, false, -5, 13);
            
    // Create particles above the player
    repeat(3) {
        instance_create_layer(x, y - sprite_height / 2, "Instances_2", oStarSmol);
    }
}

check_ladder_collision = function() {
    if not ds_exists(ladder_list, ds_type_list) then return;

    ds_list_clear(ladder_list);

    var ladder_count = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oLadderParent, false, true, ladder_list, true);

    if ladder_count <= 0 or not key_jump {
        on_ladder = false;
        return;
    }

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
}

check_snail_spike_collision = function() {
    if not (place_meeting(x, y + 1, oSnailGray)
    	or (place_meeting(x, y + 1, oSnail) and not night)
    	or (place_meeting(x, y + 1, oSnailNight) and night)
    ) or vsp <= -1.75
    or state.state_is("win")
    or godmode {
    	return;
    }

    instance_destroy();
}

check_wall_squash_collision = function() {
   if not place_meeting(x, y, oSolid)
	or object_is_outside_room()
   or state.state_is("win")
   or godmode {
		return;
   }

	show_debug_message("THE PLAYER WAS SQUASHED!!!");
   instance_destroy(); 
   squash = true;
}

check_star_collision = function() {
    var _star = instance_place(x, y, oStar);

    if _star == noone then return;
    if not _star.visible then return;

    if _star.sprite_index == sStarDaySpike
    and not state.state_is("win")
    and not godmode {
        instance_destroy();
        return;
    }

    if not _star.neww {
        if stars_collected == 0 then audio_play_sfx(sndStar1, false, -9.3, 0);
        if stars_collected == 1 then audio_play_sfx(sndStar2, false, -9.3, 0);
        if stars_collected == 2 then audio_play_sfx(sndStar3, false, -9.3, 0);
        if stars_collected >= 3 and global.settings.enable_sfx then 
            audio_play_sound(sndStar3, 10, false, power(10, -9.3 / 20), 0, 1.05);
    }

    instance_destroy(_star);
    stars_collected += 1;
    flash = 1;
}

check_perma_spike_collision = function() {
    if not instance_exists(oPermaSpike)
    or state.state_is("win")
    or godmode
    or collision_rectangle(x - 2, y - 2, x + 2, y + 4, oPermaSpike, false, false) == noone
    or place_meeting(x, y, oNope) {
    	return;
    }

    instance_destroy();
}

check_mushroom_collision = function() {
   var nearmush = instance_place(x, y, oMush);

   if nearmush == noone then return;
	 
   var _mush_angle = nearmush.image_angle;
   var _mush_xscale = nearmush.image_xscale;
   var _mush_yscale = nearmush.image_yscale;

   if nearmush.image_speed != 0 then return;

   var _play_mush_sound = function() {
      audio_play_sfx(choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04), false, -16, 2);
   }

   var _spawn_mush_particles = function() {
      repeat(irandom_range(3, 5)) {
         var dust = instance_create_layer(x, y + (sprite_height / 2), "Instances_2", oBigDust);
         dust.hsp = hsp / random_range(5, 10);
         dust.vsp = vsp / random_range(5, 10);
      }
   }

	if (_mush_angle == 0) and vsp >= 0 { // Mush is facing up
      if not nearmush.gray {
         scr_change();
      }
        
      y = nearmush.y;
      nearmush.image_speed = 1;
      grace_time = 0;
        
      if instance_exists(oMagicOrb) and not nearmush.gray {
         oMagicOrb.vsp = -(jumpspeed + 0.65)
      } else {
         vsp = -(jumpspeed + 0.65)
      }
        
      image_index = 0;

      _play_mush_sound();
      shake_gamepad(0.4, 2);
		_spawn_mush_particles();
	} else if (_mush_angle == -90 or _mush_angle == 270) and numb == 0 { // Mush is facing right
	   if not nearmush.gray {
	      scr_change();
	   }

	   numb = 10;
	   vsp = -0.5;

	   nearmush.image_speed = 1;
	   grace_time = 0;
	   if instance_exists(oMagicOrb) and not nearmush.gray {
	      oMagicOrb.hsp = jumpspeed
	   } else {
	      hsp = jumpspeed
	   }
        
	   v_fric = 0;
	   image_index = 0;
	   _play_mush_sound();
		shake_gamepad(0.4, 2);
	   _spawn_mush_particles();
   } else if (_mush_angle == -270 or _mush_angle == 90) and numb == 0 { // Mush is facing left
      if not nearmush.gray {
         scr_change();
      }

      numb = 10;
      vsp = -0.5;

      nearmush.image_speed = 1;
      grace_time = 0;
        
      if instance_exists(oMagicOrb) and not nearmush.gray {
         oMagicOrb.hsp = -jumpspeed;
      } else {
         hsp = -jumpspeed;
      }
            
      v_fric = 0;
      image_index = 0;
      _play_mush_sound();
		shake_gamepad(0.4, 2);
      _spawn_mush_particles();
   } else if abs(_mush_angle) == 180 or (_mush_angle == 0 and _mush_yscale == -1) and vsp < 0 { // Mush is facing down
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
        
      _play_mush_sound();
		shake_gamepad(0.4, 2);
      _spawn_mush_particles();
   }
}