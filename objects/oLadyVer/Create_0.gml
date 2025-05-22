levelnumb = 0;
night = false;
hsp = 0;
vsp = 0;
prevsp = 0;
cx = 0;
cy = 0;
xx = 0;
yy = 0;
maxspd = 0.55;
drawy = y;
nearmush_list = ds_list_create();
my_change = false;

smove_day=sLadyNight
sturn_day=sLadyTurn
smove_dayB=sLadyDay
sturn_dayB=sLadyTurnNight

startindex = image_index;

// Moonleap Maker flips the object changing image_xscale instead of image_index
if sign(image_yscale) == -1 {
	vsp = maxspd;
	startindex = 1;
}

vsp = startindex == 1 ? maxspd : -maxspd;
image_angle = -90;
sprite_index = startindex == 0 ? sLadyNight : sLadyDay;

if instance_exists(oGrassDay)
or (instance_exists(oLevelMaker) and oLevelMaker.selected_style == LEVEL_STYLE.GRASS) {
	palette_index = 0;
} else if instance_exists(oCloudDay)
or (instance_exists(oLevelMaker) and oLevelMaker.selected_style == LEVEL_STYLE.CLOUDS) {
	palette_index = 1;
} else if instance_exists(oFlowerDay)
or (instance_exists(oLevelMaker) and oLevelMaker.selected_style == LEVEL_STYLE.FLOWERS) {
	palette_index = 2;
} else if instance_exists(oSpaceDay)
or (instance_exists(oLevelMaker) and oLevelMaker.selected_style == LEVEL_STYLE.SPACE) {
	palette_index = 3
} else if instance_exists(oDunDay)
or (instance_exists(oLevelMaker) and oLevelMaker.selected_style == LEVEL_STYLE.DUNGEON) {
	palette_index = 4;
}

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
      or prevsp != maxspd
      or _nearmush.bbox_top < bbox_bottom {
        continue;
      }

      prevsp = -maxspd;
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
      or prevsp != -maxspd
      or _nearmush.bbox_top > bbox_bottom {
        continue;
      }

      prevsp = maxspd;
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
