hsp = 0;
vsp = 0;

dir = image_xscale;
drawhsp = image_xscale;
image_xscale = 1;

hsp = image_index == 1 ? 0.5 : -0.5;
startindex = image_index;
night = false;
early_night = false;

cx = 0;
cy = 0;

layer = layer_get_id("Instances_2");
drawy = y;

prehsp = hsp;

xx = x;
yy = y;

change = false
palette_index = 4;

nearmush_list = ds_list_create();

image_index = 0;

set_pallete_index();

play_mushroom_sound = function() {
	if audio_is_playing_any([snd_cogumelo_01,snd_cogumelo_02,snd_cogumelo_03,snd_cogumelo_04]) then return;
	
	var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
				
	audio_play_sfx(sfxcogu, false, -16, 2);
}

check_mushroom_collision = function() {
  if not ds_list_empty(nearmush_list) then ds_list_clear(nearmush_list);
  
  var _nearmush_amount = instance_place_list(x + 1, y, oMush, nearmush_list, true);
  
  if _nearmush_amount > 0 {
    for (var i = 0; i < _nearmush_amount; i++) {
      var _nearmush = ds_list_find_value(nearmush_list, i);
  
      if not instance_exists(_nearmush)
      or not (_nearmush.image_angle == 90 or _nearmush.image_angle == -270)
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

  _nearmush_amount = instance_place_list(x - 1, y, oMush, nearmush_list, true);

  if _nearmush_amount > 0 {
    for (var i = 0; i < _nearmush_amount; i++) {
      var _nearmush = ds_list_find_value(nearmush_list, i);

      if not instance_exists(_nearmush)
      or not (_nearmush.image_angle == 270 or _nearmush.image_angle == -90)
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
