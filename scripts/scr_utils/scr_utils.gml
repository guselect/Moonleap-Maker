/// @desc Safe struct value loading
function struct_read(_struct, _property, _default) {
	var _val = variable_struct_get(_struct, _property);
	return is_undefined(_val) ? _default : _val;
}

function struct_clone(_struct) {
	if not is_struct(_struct) then return undefined;
	
	var _new_struct = {};
	var _names = variable_struct_get_names(_struct);
	
	for (var i = 0; i < array_length(_names); i++) {
		var _name = array_get(_names, i);
		var _value = variable_struct_get(_struct, _name);
		
		// If value is struct, apply recursion
		if is_struct(_value) {
			_value = struct_clone(_value);
		} else if is_method(_value) {
			// If value is method, set method reference to the new struct and return it.
			_value = method(_new_struct, _value);
		}
		
		variable_struct_set(_new_struct, _name, _value);
	}
	
    return _new_struct;
}

function room_is(_room_or_room_array) {
    if not is_array(_room_or_room_array) {
        return room == _room_or_room_array;
    }

    for (var i = 0; i < array_length(_room_or_room_array); i++) {
        var _current_room = array_get(_room_or_room_array, i);
    
        if room == _current_room then return true;
    }

    return false;
}

function audio_is_playing_any(_audio_array) {
    for (var i = 0; i < array_length(_audio_array); i++) {
        var _audio = array_get(_audio_array, i);
    
        if audio_is_playing(_audio) then return true;
    }

    return false;
}

function instance_exists_any(_instance_array) {
    for (var i = 0; i < array_length(_instance_array); i++) {
        var _instance = array_get(_instance_array, i);
    
        if instance_exists(_instance) then return true;
    }

    return false;
}

function object_set_room_wrapping() {
   if x < 0 then x += room_width; 
   if x > room_width then x -= room_width;
   if y < 0 then y += room_height;
   if y > room_height then y -= room_height;
}

function object_is_outside_room() {
	return x < 0 or x >= room_width or y < 0 or y >= room_height;
}

function set_pallete_index() {
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

function is_at_hub() {
	return room == Room100;
}

function on_desktop() {
	return ((os_type == os_windows) or (os_type == os_linux) or (os_type == os_macosx));
}

function draw_text_shadow(_x, _y, _text, _shadow_offset_x, _shadow_offset_y, _shadow_color) {
	var prev_color = draw_get_color();
	
	draw_set_color(_shadow_color);
	draw_text(_x + _shadow_offset_x, _y + _shadow_offset_y, _text);
	draw_set_color(prev_color);
	draw_text(_x, _y, _text);
}

function room_transit(_target) {
	var trans = instance_create_layer(0, 0, layer, oTransition);
	
	trans.target_room = _target;
}