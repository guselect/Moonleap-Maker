/// @desc This function returns the value of the key from a struct whether it's not undefined. Otherwise it returns the provided `_default` value.
/// @param {Struct} _struct The struct to find the value.
/// @param {String} _property The key name of the struct.
/// @param {Any} _default The value to return whether the value of the struct key is undefined.
function struct_read(_struct, _property, _default) {
	var _val = variable_struct_get(_struct, _property);
  
	return is_undefined(_val) ? _default : _val;
}

/// @desc This function checks whether the current room is the room or one of the rooms provided.
/// @param {Asset.GMRoom|Array<Asset.GMRoom>} _room The room or an array of rooms to check.
function room_is(_room) {
  if not is_array(_room) {
    return room == _room;
  }

  return array_any(_room, function(_cur_room) {
    return room == _cur_room;
  });
}

/// @desc This function checks whether an audio into the `_audio_array` is a valid sound and it's currently playing.
/// @param {Array<Asset.GMAudio>} _audio_array An array of audio.
function audio_is_playing_any(_audio_array) {
  return array_any(_audio_array, function(_audio) {
    return asset_get_type(_audio) == asset_sound and audio_is_playing(_audio);
  });
}

/// @desc This function uses `instance_exists` function on every instance into the array on `_instance_array` variable and returns `true` whether any of the instance or object exists in the current room.
/// @param {Array<Asset.GMObject>|Array<Id.Instance>} _obj_array The array of objects or instances to check the existance of.
function instance_exists_any(_obj_array) {
  return array_any(_obj_array, function(_obj) {
    return instance_exists(_obj);
  })
}

/// @desc This function changes the current object's position when it is outside the room. If it's at the outside left of the room, it goes to the right side of the room and vice-versa. The same happens for the vertical position.
function object_set_room_wrapping() {
   if x < 0 then x += room_width; 
   if x > room_width then x -= room_width;
   if y < 0 then y += room_height;
   if y > room_height then y -= room_height;
}

/// @desc This function checks whether the current object is outside the current room.
function object_is_outside_room() {
	return x < 0 or x >= room_width or y < 0 or y >= room_height;
}

function set_palette_index_by_level_style() {
	if instance_exists(oGrassDay) {
		palette_index = 0;
	} else if instance_exists(oCloudDay) {
		palette_index = 1;
	} else if instance_exists(oFlowerDay) {
		palette_index = 2;
	} else if instance_exists(oSpaceDay) {
		palette_index = 3;
	} else if instance_exists(oDunDay) {
		palette_index = 4;
	}
}

function in_hub_view() {
	var _x1 = min(oCamera.hubx,oCamera.hubx_prev);
	var _y1 = min(oCamera.huby,oCamera.huby_prev);
	var _x2 = max(oCamera.hubx,oCamera.hubx_prev)+oCamera.view_width;
	var _y2 = max(oCamera.huby,oCamera.huby_prev)+oCamera.view_height;
	return rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, _x1, _y1, _x2, _y2);
}

/// @desc This function checks whether the current room is the game's main hub.
function is_at_hub() {
	return room_is([Room100]);
}

/// @description This function checks whether the current OS is one of the items in the array.
/// @param {Array<Constant.OperatingSystem>} os_type_array An array of OS types.
function is_os_type_any(_os_type_array) {
  return array_any(_os_type_array, function(_os_type) { return os_type == _os_type });
}

/// @desc This function checks whether the current OS is desktop.
function is_on_desktop() {
	return is_os_type_any([os_windows, os_linux, os_macosx]);
}

/// @desc This function checks whether the current OS is console.
function is_on_console() {
	return is_os_type_any([os_ps4, os_ps5, os_xboxseriesxs, os_gdk, os_switch, os_switch2]);
}

/// @desc This function checks whether the current OS is mobile.
function is_on_mobile() {
	return is_os_type_any([os_android, os_ios]);
}

function draw_text_shadow(_x, _y, _text, _shadow_offset_x, _shadow_offset_y, _shadow_color) {
	var prev_color = draw_get_color();
	
	draw_set_color(_shadow_color);
	draw_text(_x + _shadow_offset_x, _y + _shadow_offset_y, _text);
	draw_set_color(prev_color);
	draw_text(_x, _y, _text);
}

/// @description Calls the transition effects and redirects to the room target.
/// @param {Asset.GMRoom} room_target The room to transit.
function room_transit(_room_target, _layer = layer) {
	var _transition = instance_create_layer(0, 0, _layer, oTransition);
	_transition.target_room = _room_target;
}

/// @desc Gets the object's sprite horizontal center regardless the sprite origin.
/// @param {Asset.GMObject} _object The object to find the sprite's center.
function object_get_sprite_center_x(_object) {
  with(_object) {
    return x - sprite_xoffset + sprite_width / 2;
  }
}

/// @desc Gets the object's sprite vertical center regardless the sprite origin.
/// @param {Asset.GMObject} _object The object to find the sprite's center.
function object_get_sprite_center_y(_object) {
  with(_object) {
    return y - sprite_yoffset + sprite_height / 2;
  }
}

/// @desc Formats a string to be compatible to files' names.
/// @param {string} _str String to be formatted.
function string_filename_create(_str) {
  var _new_name = _str;
  
  // Removes the start and end spaces.
  _new_name = string_trim(_new_name);
  
  // The inner spaces are replaced by underscores.
  _new_name = string_replace_all(_new_name, " ", "_"); 
  
  // Lowercase to all letters.
  _new_name = string_lower(_new_name);
  
  // Removes all symbols from the name
  for (var i = 32; i <= 255; i++) {
    if (i >= 48 and i <= 57)
    or (i >= 65 and i <= 90)
    or (i == 95)
    or (i >= 97 and i <= 122)
    or (i >= 192 and i <= 214)
    or (i >= 216 and i <= 246)
    or (i >= 248 and i <= 255) {
      continue;
    }
    _new_name = string_replace_all(_new_name, chr(i), "");
  }
  
  return _new_name;
}

/// @desc This function draws a rectangle border around the collision bounding box.
/// @param {Constant.Color} _color The rectangle border color.
/// @param {bool} _outline Whether the outline will be drawn instead of fill. Default: `true`.
/// @param {real} _alpha The rectangle alpha. Default: `1`.
function draw_bbox_rect(_color = c_orange, _outline = true, _alpha = 1) {
  draw_set_alpha(_alpha);
  draw_set_color(_color);
  draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, _outline);
  
  draw_reset();
}