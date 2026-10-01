/*
 * This script holds functions of all the menus composed with their options.
 * 
 * Each function returns a menu represented by an array with options of
 * MenuOption* struct type with their configuration set.
 * 
 * You can add, modify or erase any of the options and menus of the game here.
 */

function menu_play_redirect_option_sound() {
  audio_play_sfx(sndStarGame, false, -6, 0);
}

function menu_get_main() {
  var _menu_main = [
    // Start
    new MenuOptionActionCall(
      function() { return LANG.text_start; },
      function() {
        var _room = Room100;
        if oCamera.arcade {
          _room = Room0;
        }
        menu_play_redirect_option_sound();
        room_transit(_room);
      }
    ),

    // Options
    new MenuOptionMenuCall(
      function() { return LANG.text_options; },
      "options",
    ),

    // Credits
    new MenuOptionActionCall(
      function() { return LANG.text_credits; },
      function() {
        menu_play_redirect_option_sound();
        room_transit(RoomCreditsAlves);
      }
    )
  ];

  // Options available only on desktop releases.
  if is_on_desktop() {
    // Level Maker
    array_push(_menu_main, new MenuOptionActionCall(
      function() { return LANG.maker_name; },
      function() {
        menu_play_redirect_option_sound();
        room_transit(RoomMakerMenu);
      }
    ));

    // Exit game
    array_push(_menu_main, new MenuOptionActionCall(
      function() { return LANG.text_exit; },
      function() {
        game_end();
      }
    ));
  }

  return _menu_main;
};

function menu_get_level_pause() {
  var _menu_pause = [
    // Resume
    new MenuOptionCloseMenu(
      function() { return LANG.text_resume; },
    ),

    // Options
    new MenuOptionMenuCall(
      function() { return LANG.text_options; },
      "options",
    ),
  ];
  
  // Change level
  if not room_is(RoomMaker0) {
    array_push(_menu_pause, 
      new MenuOptionActionCall(
        function() { return LANG.text_changelevel; },
        function() { 
          if not instance_exists(oTransition) {
            audio_play_sfx(sndStarGame, false, -6.2, 0);  
            room_transit(Room100);
          }
        }
      ),
    );
  }
  
  // Give up
  array_push(_menu_pause, 
    new MenuOptionActionCall(
      function() { return LANG.text_giveup; },
      function() { 
        if not instance_exists(oTransition) {
          audio_sound_gain(bgm_hub   , 0, 1000);
          audio_sound_gain(bgm_hub_01, 0, 1000);
          audio_sound_gain(bgm_hub_02, 0, 1000);
          audio_sound_gain(bgm_hub_03, 0, 1000);
          audio_sound_gain(bgm_hub_04, 0, 1000);
          audio_play_sfx(sndStarGame, false, -6.2, 0);
          room_transit(room_is(RoomMaker0) ? RoomMakerMenu : RoomMenu);
        }
      }
    ), 
  );
  
  return _menu_pause;
}

function menu_get_options() {
  var _menu_options = [
    // Vibrate
    new MenuOptionActionCall(
      function() { 
        var _vibration_percent = round(global.settings.vibration * 100);
        return $"{LANG.text_vibrate}{_vibration_percent}%";
      },
      function() {
        global.settings.vibration += 0.1;
        if (global.settings.vibration > 1)
          global.settings.vibration = 0;
        shake_gamepad(0.75, 10);
      }
    ),

    // Sound & Video
    new MenuOptionMenuCall(
      function() { return LANG.text_soundvideo; },
      "soundvideo"
    ),

    // Assist
    new MenuOptionMenuCall(
      function() { return LANG.text_assist; },
      "assist"
    ),

    // Language
    new MenuOptionActionCall(
      function() { return $"{LANG.text_language}{lang_get()}"; },
      function() {
        var _langs = ["EN","PT-BR","JA","ES","IT","ZH"];
        var _lang_index = array_find_index_of_value(_langs,lang_get());
        _lang_index++;
        if (_lang_index >= array_length(_langs)) _lang_index = 0;
        lang_set(_langs[_lang_index]); //update current language				 
      }
    ),
    //new MenuOptionValueToggle(
      //function() { return $"{LANG.text_language}{lang_get()}"; },
      //["EN", "PT-BR", "JA", "ES", "IT", "ZH"],
      //function(_langs) {
        //return array_find_index_of_value(_langs, lang_get())
      //},
      //function(_lang) {
        //lang_set(_lang);
      //}
    //),

    // Delete save
    new MenuOptionMenuCall(
      function() { return LANG.text_deletesave; },
      "deletesure"
    ),

    // Go back
    new MenuOptionMenuCall(
      function() { return LANG.text_back; },
      "main",
      function() { oSaveManager.save = true; }
    ),
  ];

  return _menu_options;
}

function menu_get_assist() {
  var _menu_assist = [
    // Colorblind
    new MenuOptionActionCall(
      function() { 
        var _filter_state = global.settings.filter ? LANG.text_ON : LANG.text_OFF
        return $"{LANG.text_colorblind}{_filter_state}";
      },
      function() { global.settings.filter = !global.settings.filter; },
      function() { return LANG.text_full_colorblind }
    ),

    // Game speed
    new MenuOptionActionCall(
      function() { return $"{LANG.text_speed}{global.settings.gamespd}%"; },
      function() {
        global.settings.gamespd -= 10;
        if (global.settings.gamespd <= 40) global.settings.gamespd = 100;
        game_set_speed((global.settings.gamespd / 100) * 60, gamespeed_fps);
      },
      function() { return LANG.text_full_speed }
    ),

    // Go back
    new MenuOptionMenuCall(
      function() { return LANG.text_back; },
      "options",
      function() { oSaveManager.save = true; }
    ),
  ];

  return _menu_assist;
}

function menu_get_soundvideo() {
  var _menu_soundvideo = [
    // Music
    new MenuOptionActionCall(
      function() { 
        var _music_state = global.settings.bgm_volume ? LANG.text_ON : LANG.text_OFF;
        return $"{LANG.text_music}{_music_state}";
      },
      function() { bgm_set_volume(!global.settings.bgm_volume) },
    ),

    // Sound effects
    new MenuOptionActionCall(
      function() { 
        var _sfx_state = global.settings.enable_sfx ? LANG.text_ON : LANG.text_OFF;
        return $"{LANG.text_sfx}{_sfx_state}";
      },
      function() { global.settings.enable_sfx = !global.settings.enable_sfx; },
    ),
    
    // Fullscreen
    new MenuOptionActionCall(
      function() { 
        var _fullscreen_state = window_get_fullscreen() ? LANG.text_ON : LANG.text_OFF;
        return $"{LANG.text_fullscreen}{_fullscreen_state}";
      },
      function() { 
        global.settings.fullscreen = !global.settings.fullscreen;
        window_set_fullscreen(global.settings.fullscreen);
        window_set_size(GUI_W * global.settings.window_scale, GUI_H * global.settings.window_scale);
      },
    ),
    // Window scale
    new MenuOptionActionCall(
      function() { 
        return $"{LANG.text_windowscale}x{global.settings.window_scale}";
      },
      function() {
        global.settings.window_scale += 1;
        if (global.settings.window_scale > 5) global.settings.window_scale = 1
        window_set_size(GUI_W * global.settings.window_scale, GUI_H * global.settings.window_scale);
      },
    ),

    // Go back
    new MenuOptionMenuCall(
      function() { return LANG.text_back; },
      "options",
      function() { oSaveManager.save = true; }
    ),
  ];

  return _menu_soundvideo;
}

function menu_get_deletesure() {
  var _menu_deletesure = [
    new MenuOptionBase(
      function() { return LANG.text_sure; },
    ),
    new MenuOptionMenuCall(
      function() { return LANG.text_yes; },
      "main",
      function() {
        with (oSaveManager) {
          first_save = true;
          event_user(1);
        }
        audio_play_sfx(sfx_luano_death_pause_01, false, -8.79, 5);
        oCamera.shake = 2;
      },
      function() { return LANG.text_savecaution; }
    ),
    new MenuOptionMenuCall(
      function() { return LANG.text_no; },
      "options"
    ),
  ];

  _menu_deletesure[0].can_play_select_sound = false;

  for (var _i = 0; _i < array_length(_menu_deletesure); _i++) {
    _menu_deletesure[_i].is_dangerous = true;
  }

  return _menu_deletesure;
}
