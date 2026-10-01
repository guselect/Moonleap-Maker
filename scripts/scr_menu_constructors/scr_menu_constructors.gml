/*
 * This script holds all the menu option constructors for a menu composition.
 * 
 * If you wish to make a new menu option with different functionality,
 * create a constructor at the end of this script inheriting one of the
 * menu option constructors available.
 * 
 * Once you create your own menu option constructor, make an adaptation of its
 * functionality on the oMenuController object in order to work in-game.
 * 
 * For manners of documentation and organization, it's recommended to keep all 
 * constructors well documented with JSDoc as shown in the existing constructors.
 */ 

/// @desc The constructor of base menu option. There is no functionality once it is triggered
/// and it is used as base for making other menu option contructors.
/// @param {string|Function} label The menu label. Can be a string for hardcoded label or a function to return a dynamic label.
/// @param {string|Function} description OPTIONAL. The description to display at the window footer. Can be a string for hardcoded description or a function to return a dynamic description.
function MenuOptionBase(_label = "", _description = undefined) constructor {
  label = _label;
  description = _description;
  is_dangerous = false;
  can_play_select_sound = true;

  get_label = function() {
    if is_method(label) {
      return label();
    }
    return label;
  };

  get_description = function() {
    if is_method(description) {
      return description();
    }
    return description;
  };
}

/// @desc The constructor of menu option that runs an action when this option is triggered.
/// @param {string|Function} label The menu label. Can be a string for hardcoded label or a function to return a dynamic label.
/// @param {Function} action The action when this option is triggered.
/// @param {string|Function} description The description to display at the window footer. Can be a string for hardcoded description or a function to return a dynamic description.
function MenuOptionActionCall(_label = "", _action_callback, _description = undefined): MenuOptionBase(_label, _description) constructor {
  action_callback = _action_callback;

  run_action = method(self, function() {
    if not is_method(action_callback) {
      return;
    }
    action_callback();
  });
}

/// @desc The constructor of menu option that redirects to another menu when it is triggered.
/// @param {string|Function} label The menu label. Can be a string for hardcoded label or a function to return a dynamic label.
/// @param {string} menu_name The menu which will be changed when triggering this option.
/// @param {Function} action The action when this option is triggered.
/// @param {string|Function} description The description to display at the window footer. Can be a string for hardcoded description or a function to return a dynamic description.
function MenuOptionMenuCall(_label = "", _menu_name, _action = undefined, _description = undefined): MenuOptionActionCall(_label, _action, _description) constructor {
  menu_name = _menu_name;
}

/// @desc The constructor of menu option that closes the menu when it is triggered.
/// @param {string|Function} label The menu label. Can be a string for hardcoded label or a function to return a dynamic label.
/// @param {Function} action The action when this option is triggered.
/// @param {string|Function} description The description to display at the window footer. Can be a string for hardcoded description or a function to return a dynamic description.
function MenuOptionCloseMenu(_label = "", _action = undefined, _description = undefined): MenuOptionActionCall(_label, _action, _description) constructor {}

/// @desc The constructor of menu option that toggles a value by selecting it and pressing directional buttons.
function MenuOptionDirectionalToggle(_label = "", _description = undefined): MenuOptionBase(_label, _description) constructor {
  get_label = function(is_toggling = false) {
    if is_method(label) {
      return label(is_toggling);
    }
    return label;
  };
  
  toggle_left_callback = function() {};
  toggle_right_callback = function() {};
  toggle_up_callback = function() {};
  toggle_down_callback = function() {};
}