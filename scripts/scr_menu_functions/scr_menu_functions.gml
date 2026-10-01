/// @desc Instantiates `oMenuController` in the room with given menus and configuration preset.
/// @param {Struct} menu_list_struct The menus list in struct format.
/// @param {string} first_menu_name The name of the first menu to display on screen.
/// @param {string|Id.Layer} layer The layer where `oMenuController` will be instantiated.
/// @param {bool} fill_background Whether the entire background will be filled. Default: `false`.
/// @param {bool} show_game_version Whether the game version will be displayed at bottom right corner with the menu. Default: `false`.
/// @param {bool} show_title Whether the title will be displayed at the top of the menu options. Default: `false`.
/// @param {bool} use_alt_colors Whether the menu use alternative colors on texts. Default: `false`.
function menu_call_layer(_menu_list_struct, _first_menu_name, _layer, _fill_background = false, _show_game_version = false, _show_title = false, _use_alt_colors = false) {
  var _menu_controller = instance_create_layer(0, 0, _layer, oMenuController);
  _menu_controller.menus = _menu_list_struct;
  _menu_controller.current_menu_name = _first_menu_name;
  _menu_controller.fill_background = _fill_background;
  _menu_controller.show_game_version = _show_game_version;
  _menu_controller.show_title = _show_title;
  _menu_controller.use_alt_colors = _use_alt_colors;
  
  return _menu_controller;
}

function menus_get_main() {
  var _menu_list = {
    main: menu_get_main(),
    options: menu_get_options(),
    assist: menu_get_assist(),
    soundvideo: menu_get_soundvideo(),
    deletesure: menu_get_deletesure(),
  };

  return _menu_list;
}

function menus_get_level_pause() {
  var _menu_list = {
    main: menu_get_level_pause(),
    options: menu_get_options(),
    assist: menu_get_assist(),
    soundvideo: menu_get_soundvideo(),
    deletesure: menu_get_deletesure(),
  };

  return _menu_list;
}

function menus_get_level_maker() {
  var _menu_list = {
    main: menu_get_main(),
    options: menu_get_options(),
    assist: menu_get_assist(),
    soundvideo: menu_get_soundvideo(),
    deletesure: menu_get_deletesure(),
  };

  return _menu_list;
}