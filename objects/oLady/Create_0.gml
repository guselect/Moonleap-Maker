night = false;
hsp = 0;
vsp = 0;
cx = 0;
cy = 0;
xx = 0;
yy = 0;
maxspd = 0.55;
levelnumb = 0;

smove_day=sLadyNight
sturn_day=sLadyTurn
smove_dayB=sLadyDay
sturn_dayB=sLadyTurnNight

startindex = image_index;

nearmush_list = ds_list_create();

// Moonleap Maker flips the object changing image_xscale instead of image_index
if sign(image_xscale) == -1 {
	hsp = -maxspd;
	startindex = 1;
}

hsp = startindex == 1 ? -maxspd : maxspd;
image_xscale = sign(hsp);
sprite_index = startindex == 0 ? smove_day : smove_dayB;

layer=layer_get_id("Instances_2")
drawy = y;

prehsp = hsp;

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
  if not audio_is_playing_any([snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04]) {
    var sfxcogu = choose(snd_cogumelo_01, snd_cogumelo_02, snd_cogumelo_03, snd_cogumelo_04);
    audio_play_sfx(sfxcogu,false,-16,2)
  } 
}

spawn_dust_particles = function() {
  repeat(irandom_range(3, 5)) {
    var dust = instance_create_layer(x - (sprite_width / 2), y, "Instances_2", oBigDust);
    dust.hsp = hsp / random_range(5, 10);
    dust.vsp = vsp / random_range(5, 10);
  }
}

check_mushroom_collision = function() {
  if not ds_list_empty(nearmush_list) then ds_list_clear(nearmush_list);
  
  var _nearmush_amount = instance_place_list(x + 1, y, oMush, nearmush_list, true);
  
  if _nearmush_amount > 0 {
    for (var i = 0; i < _nearmush_amount; i++) {
      var _nearmush = ds_list_find_value(nearmush_list, i);
  
      if not instance_exists(_nearmush)
      or not (_nearmush.image_angle == 90 or _nearmush.image_angle == -270)
      or _nearmush.glued
      or prehsp != maxspd
      or _nearmush.bbox_left < bbox_right {
        continue;
      }

      prehsp = -maxspd;
      if _nearmush.object_index == oMush then
        scr_change();
      else 
        change = true;

      _nearmush.image_speed = 1;
      play_mushroom_sound();
      shake_gamepad(0.4, 2);
			spawn_dust_particles();
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
      or _nearmush.glued
      or prehsp != -maxspd
      or _nearmush.bbox_left > bbox_right {
        continue;
      }

      prehsp = maxspd;
      if _nearmush.object_index == oMush then 
        scr_change();
      else
        change = true;

      _nearmush.image_speed = 1;
      play_mushroom_sound();
      shake_gamepad(0.4, 2);
			spawn_dust_particles();
      return;
    }
  }
}