function scr_moving_plat(_cx = hsp, _cy = vsp) {
	if instance_exists_any([oPauseUI, oDead])
	or (instance_exists(oTransition) and oTransition.title_display_wait != 0)
  or maker_transition_is_running()
	or (not instance_exists(oPlayer) or (instance_exists(oPlayer) and oPlayer.state.state_is("win"))) {
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
	repeat(abs(vsp_new)) {
		// Se não colidir com terreno verticalmente
		if not has_collided(0, sign(vsp_new), true, [], [oSnail, oSnailNight, oSnailGray]) {
      var _moveables = [oPlayer, oSnail, oSnailNight, oSnailGray, oStarRunning, oStarColor, oStarRunningColor, oStar, oMagicOrb];
      var _above = instance_place_array_wrap_room(x, y - 1, _moveables);
      
      for (var i = 0; i < array_length(_above); i++) {
        var _inst_above = _above[i];
        
        __move_object_above_vertical(id, _inst_above, vsp_new);
      }
      
			y += sign(vsp_new)
		} else {
      vsp = 0;
      break;
		}
	}

	// Movimento horizontal
	repeat(abs(hsp_new)) {
		// Se não colidir com terreno, mova os seguintes objetos acima dele.
    if (not has_collided(sign(hsp_new), 0, true, [oPermaSpike])) {
      var _moveables = [oPlayer, oSnail, oSnailNight, oSnailGray, oStarRunning, oStarColor, oStarRunningColor, oStar, oMagicOrb];
      var _above = instance_place_array_wrap_room(x, y - 1, _moveables);
      
      for (var i = 0; i < array_length(_above); i++) {
        var _inst_above = _above[i];
        
        __move_object_above_horizontal(id, _inst_above, hsp_new);
      }

			x += sign(hsp_new);
    } else {
      hsp = 0;
      break;
    }
	}
}

/// @desc Makes the `inst_above` move with the `inst_move` vertically.
/// @param {Id.Instance} inst_move The instance as moving platform.
/// @param {Id.Instance} inst_above The instance above the moving platform.
/// @param {real} vsp_final The final vertical velocity of the `inst_move`.
function __move_object_above_vertical(inst_move, inst_above, vsp_final) {
  with (inst_above) {
    if can_collision_wrap() {
      if (
        place_meeting_wrap_room(x, y + 1, inst_move)
        and sign(vsp) >= 0
        and not place_meeting_exception_wrap_room(x, y + sign(vsp_final), oSolid, inst_move)
      ) 
      or (
        place_meeting_wrap_room(x, y - 1, inst_move) 
        and sign(vsp_final) == 1
      ) 
      {
        y += sign(vsp_final);
      }
      return;
    }
    
    if (
      place_meeting(x, y + 1, inst_move)
      and sign(vsp) >= 0
      and not place_meeting_exception(x, y + sign(vsp_final), oSolid, inst_move)
    ) 
    or (
      place_meeting(x, y - 1, inst_move) 
      and sign(vsp_final) == 1
    )
    {
      y += sign(vsp_final);
    }
  }
}

/// @desc Makes the `inst_above` move with the `inst_move` horizontally.
/// @param {Id.Instance} inst_move The instance as moving platform.
/// @param {Id.Instance} inst_above The instance above the moving platform.
/// @param {real} hsp_final The final horizontal velocity of the `inst_move`.
function __move_object_above_horizontal(inst_move, inst_above, hsp_final) {
  with (inst_above) {
    if can_collision_wrap() {
      if place_meeting_wrap_room(x - sign(hsp_final), y, inst_move)
      or (
        not has_collided(sign(hsp_final), 0)
        and place_meeting_wrap_room(x, y + 1, inst_move)
      )
      {
        x += sign(hsp_final);
      }
      return;
    }
    
    if place_meeting(x - sign(hsp_final), y, inst_move)
    or (
      not has_collided(sign(hsp_final), 0)
      and place_meeting(x, y + 1, inst_move)
    ) 
    {
      x += sign(hsp_final);
    }
  }
}