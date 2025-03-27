//show_debug_message("oStar instances:" + string(instance_number(oStar)));
//show_debug_message("oPlayer instances:" + string(instance_number(oPlayer)));

item_preview_offset_y = smooth_approach(item_preview_offset_y,0,0.25)
item_preview_offset_x = smooth_approach(item_preview_offset_x,0,0.25)

// If the level editor is not in use don't run any more code
if !instance_exists(oPause) then exit;

// This code is to prevent random misfiring clicks after you press the button to play the level again
if(just_entered_level_editor && mouse_check_button_released(mb_left)){
	just_entered_level_editor = false;
	exit;
}

//----------------------------------------
// ACTUAL EDITOR CODE FROM HERE...
//----------------------------------------

// Only gets input if not paused
scr_inputget();

hover_text = "";
selected_object = obj[selected_object_type,selected_object_position]

// ------------------------------------
// Selecting objects
// ------------------------------------
var ui_object_nav_x = key_right_pressed - key_left_pressed;

if ui_object_nav_x != 0 {
	item_preview_offset_x = 2 * sign(ui_object_nav_x);
	selected_object_position += sign(ui_object_nav_x);
	
	while selected_object_position < 0 
		or selected_object_position > object_positions_length - 1 
		or is_undefined(obj[selected_object_type, selected_object_position])
	{
		selected_object_position += sign(ui_object_nav_x);
		
		if selected_object_position < 0 then 
			selected_object_position = object_positions_length - 1;
		else if selected_object_position > object_positions_length - 1 then 
			selected_object_position = 0;
	}
	audio_play_sfx(snd_bump, false, -5, 13);
}

// Update the selected object
selected_object = obj[selected_object_type,selected_object_position];

// sprite_index = object_get_sprite(selected_object.object)
sprite_index = is_undefined(selected_object) ? -1 : object_get_sprite(selected_object.index);

// ------------------------------------
// Object rotation and scaling
// ------------------------------------

if not is_undefined(selected_object) {
	if selected_object.has_tag("can_flip") {
		if keyboard_check_pressed(ord("X")) then image_xscale *= -1;
	} else {
		image_xscale = 1;
	}
	
	if selected_object.has_tag("can_spin") {
		if keyboard_check_pressed(ord("Z")) {
			image_angle += 90;
			if image_angle >= 360 then image_angle = 0;
		}
	} else {
		image_angle = 0;
	}
}

// ------------------------------------
// Object tile mouse calculations
// ------------------------------------
is_cursor_inside_level = 
	global.level_maker_mouse_x > 0
	and global.level_maker_mouse_x < 320
	and global.level_maker_mouse_y > 0
	and global.level_maker_mouse_y < 320;

var _selected_object_sprite = is_undefined(selected_object) ? -1 : object_get_sprite(selected_object.index);
var _tile_scale = not is_undefined(selected_object) and selected_object.has_tag("grid_16") ? 2 : 1;

var _object_width = 1;
var _object_height = 1;
var _sprite_offset_x = sprite_get_xoffset(_selected_object_sprite) || 0;
var _sprite_offset_y = sprite_get_yoffset(_selected_object_sprite) || 0;

var _size = is_undefined(selected_object) ? [1, 1, 0, 0] : selected_object.get_size(tile_size, _object_width, _object_height);

_object_width = _size[0];
_object_height = _size[1];
_sprite_offset_x = _size[2];
_sprite_offset_y = _size[3];

var _selected_object_mouse_tile_x = round((global.level_maker_mouse_x - _object_width * tile_size / 2) / (_tile_scale * tile_size)) * _tile_scale;
var _selected_object_mouse_tile_y = round((global.level_maker_mouse_y - _object_height * tile_size / 2) / (_tile_scale * tile_size)) * _tile_scale;

_selected_object_mouse_tile_x = clamp(_selected_object_mouse_tile_x,0, room_tile_width - _object_width);
_selected_object_mouse_tile_y = clamp(_selected_object_mouse_tile_y,0, room_tile_height - _object_height);

var _new_offset = rotate_object_offset(_object_width,_object_height,_sprite_offset_x,_sprite_offset_y,image_angle);

_sprite_offset_x = _new_offset[0];
_sprite_offset_y = _new_offset[1];

//placing objects with centered visuals
x = _selected_object_mouse_tile_x * tile_size + _sprite_offset_x;
y = _selected_object_mouse_tile_y * tile_size + _sprite_offset_y;

// Check the object that is behind the cursor
object_grid_hovering = get_grid_object_hovering(global.level_maker_mouse_x, global.level_maker_mouse_y);

// ------------------------------------
// MOUSE ACTIONS
// ------------------------------------

// If not an eraser, switch between other two cursors.
// Finger if there's an object selected. Cursor otherwise.
if cursor != LEVEL_CURSOR_TYPE.ERASER {
	cursor = object_grid_hovering != -1 ? LEVEL_CURSOR_TYPE.FINGER : LEVEL_CURSOR_TYPE.CURSOR;
}

if is_cursor_inside_level {
	// Replace object
	if mouse_check_button_pressed(mb_left) 
		and cursor == LEVEL_CURSOR_TYPE.FINGER 
		and is_struct(object_grid_hovering)
	{
		var _obj_pos = get_x_y_from_object_index(object_grid_hovering[2]);
				
		selected_object_type = _obj_pos[0];
		selected_object_position = _obj_pos[1];
		
		remove_object_from_grid(object_grid_hovering);
	}

	// Create object
	if mouse_check_button_released(mb_left)
		and cursor == LEVEL_CURSOR_TYPE.CURSOR 
		and not is_undefined(selected_object)
		and not check_for_objects_in_grid_position(_selected_object_mouse_tile_x, _selected_object_mouse_tile_y, selected_object)
	{
		if selected_object.has_tag("is_player") {
			remove_all_player_objects_from_grid();
		}
		
		if selected_object.index == oMagicOrb 
			or selected_object.index == oGrayOrb
		{
		//if selected_object == oMagicOrb or selected_object == oGrayOrb {
			remove_orb_from_grid();
		}
		
		//instance_create_layer(x,y,"Instances",curobj,{image_xscale: oLevelMaker.image_xscale, image_angle: oLevelMaker.image_angle})
		place_object_in_object_grid(_selected_object_mouse_tile_x, _selected_object_mouse_tile_y, selected_object, oLevelMaker.image_xscale, oLevelMaker.image_angle);
		
		if instance_exists(oSolidDay) then oSolidDay.update = true;
		if instance_exists(oSolidNight) then oSolidNight.update = true;
		audio_play_sfx(snd_key2,false,-18.3,20);
		
		repeat(3) {
			var sm = instance_create_layer(x + 8, y + 8, "Instances_2", oBigSmoke);
			
			sm.image_xscale=0.5;
			sm.image_yscale=0.5;
		}
	}

	//Destroy Objects
	if (mouse_check_button(mb_right) 
		or (mouse_check_button(mb_left) 
			and cursor == LEVEL_CURSOR_TYPE.ERASER))
		and is_struct(object_grid_hovering) 
	{
		remove_object_from_grid(object_grid_hovering);
		
		audio_play_sfx(snd_brokestone,false,-5,15);
		instance_create_layer(x + 8, y + 8, "Instances_2", oBigSmoke);
		instance_create_layer(x + 8, y + 8, "Instances_2", oBigSmoke);
	}
}
