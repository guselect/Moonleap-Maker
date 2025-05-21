hsp = 0;
vsp = 0;
wing = 2;
startindex = image_index;
dir = image_yscale;
night = false;
change = false;
early_night = false;

cx = 0;
cy = 0;

drawy = y;

vsp = image_index == 1 ? 0.5 : -0.5;

xx = x;
yy = y;

nearmush_list = ds_list_create();

set_pallete_index();

mask_index = sprite_index;
image_xscale = 1;
image_yscale = 1;
image_index = 0;
layer = layer_get_id("Instances_2");

play_mushroom_sound = function() {
	if audio_is_playing_any([snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04]) then return;
	
	var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
				
	audio_play_sfx(sfxcogu, false, -16, 2);
}

check_mushroom_collision = function() {
  if not ds_list_empty(nearmush_list) then ds_list_clear(nearmush_list);
  
  var _nearmush_amount = instance_place_list(x, y + 1, oMush, nearmush_list, true);
  
  if _nearmush_amount > 0 {
    for (var i = 0; i < _nearmush_amount; i++) {
      var _nearmush = ds_list_find_value(nearmush_list, i);
  
      if not instance_exists(_nearmush)
      or not _nearmush.image_angle == 0
      or dir != 1 {
        continue;
      }

      dir *= -1;
      if _nearmush.object_index == oMush then
        scr_change();
      else 
        change = true;
      _nearmush.image_speed = 1;
      play_mushroom_sound();
      return;
    }
  }

  if not ds_list_empty(nearmush_list) then ds_list_clear(nearmush_list);

  _nearmush_amount = instance_place_list(x, y - 1, oMush, nearmush_list, true);

  if _nearmush_amount > 0 {
    for (var i = 0; i < _nearmush_amount; i++) {
      var _nearmush = ds_list_find_value(nearmush_list, i);

      if not instance_exists(_nearmush)
      or not (_nearmush.image_angle == 180 or _nearmush.image_angle == -180)
      or dir != -1 {
        continue;
      }

      dir *= -1;
      if _nearmush.object_index == oMush then 
        scr_change();
      else
        change = true;
      _nearmush.image_speed = 1;
      play_mushroom_sound();
      return;
    }
  }
}


set_wings = function() {
  if ((place_meeting(x + 1, y, oBatVer) or place_meeting(x + 1, y, oMush)))
  and (place_meeting(x - 1, y, oBatVer) or place_meeting(x - 1, y, oMush))
  and not (place_meeting(x, y, oBatVer) or place_meeting(x, y, oMush)) {
  	wing = 0;
  } else if (place_meeting(x + 1, y, oBatVer) or place_meeting(x + 1, y, oMush))
  and not (place_meeting(x, y, oBatVer) or place_meeting(x, y, oMush)) {
  	wing = 1;
  } else if (place_meeting(x - 1, y, oBatVer) or place_meeting(x - 1, y, oMush))
  and not (place_meeting(x, y, oBatVer) or place_meeting(x, y, oMush)) {
  	wing = -1;
  } else {
    wing = 2;
  }
}