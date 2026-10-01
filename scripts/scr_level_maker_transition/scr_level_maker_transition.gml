function maker_transition_start(_room_target, _title = "", _subtitle = "", _background_color = COLOR_NICE_BLACK) {
  var _transition = instance_create_layer(-16, -16, "Instances", oMakerTransition);
  
  _transition.room_target = _room_target;
  _transition.show_title = string_length(_title) > 0;
  _transition.title = _title;
  _transition.subtitle = _subtitle;
  _transition.transition_background_color = _background_color ?? COLOR_NICE_BLACK;
  
  return _transition;
}

function maker_transition_is_running() {
  return instance_exists(oMakerTransition) and not oMakerTransition.state_machine.state_is("fade_in")
}

/// @param {Asset.GMObject} _transition Use `oMakerTransition` object index.
/// @param {real} _level_style Use `LEVEL_MAKER_STYLE` enumerator value for this.
function maker_transition_set_background_color_by_level_style(_transition, _level_style) {
  if _level_style == LEVEL_MAKER_STYLE.FLOWERS
  or _level_style == LEVEL_MAKER_STYLE.SPACE
  or _level_style == LEVEL_MAKER_STYLE.DUNGEON {
    _transition.transition_background_color = c_black;
    return;
  }
  
  _transition.transition_background_color = COLOR_NICE_BLACK;
}