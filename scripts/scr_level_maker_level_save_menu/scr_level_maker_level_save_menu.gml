function menus_get_save_level() {
  var _menu_list = {
    main: menu_save_level_get_main()
  };

  return _menu_list;
}

function menu_save_level_get_main() {
  var _menu_level_editor_main = [
    // Go back to editor
    new MenuOptionCloseMenu(
      function() { return LANG.maker_back_to_editor; }
    ),
    
    // Save
    new MenuOptionCloseMenu(
      function() { return LANG.maker_level_save; },
      function() {
        var _filename = $"{string_filename_create(oLevelMaker.level_name)}.{LEVEL_MAKER_LEVEL_FILE_EXTENSION}";
        var _path = $"{LEVEL_MAKER_LEVELS_FOLDER_PATH}/{_filename}";
        
        try {
          custom_levels_directory_create();
          level_maker_save(_path);
          audio_play_sfx(sndStarGame, false, -6, 0);
          call_message_popup(LANG.maker_level_save_success);
        } catch (_error) {
          show_debug_message($"SAVE LEVEL ERROR: {_error}");
        	call_message_popup(LANG.maker_level_save_error);
        }
      }
    ),

    // Save as
    new MenuOptionCloseMenu(
      function() { return LANG.maker_level_save_as; },
      function() {
        var _path = get_save_filename("*.{LEVEL_MAKER_LEVEL_FILE_EXTENSION}", $"{string_filename_create(oLevelMaker.level_name)}.{LEVEL_MAKER_LEVEL_FILE_EXTENSION}");
        if (_path == "") {
          return;
        }
        try {
          level_maker_save(_path);
          audio_play_sfx(sndStarGame, false, -6, 0);
          call_message_popup(LANG.maker_level_save_success);
        } catch (_error) {
          show_debug_message($"SAVE LEVEL ERROR: {_error}");
          call_message_popup(LANG.maker_level_save_error);
        }
      }
    ),
  ];
  
  return _menu_level_editor_main;
};
