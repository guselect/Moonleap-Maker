yplus=smooth_approach(yplus,0,0.25)
xplus=smooth_approach(xplus,0,0.25)

//if the level editor is not in use dont run any more code
if !instance_exists(oPause) then exit;

// this code is to prevent random misfiring clicks after you press the button to play the level again
if(just_entered_level_editor && mouse_check_button_released(mb_left)){
	just_entered_level_editor = false;
	exit;
}

//----------------------------------------
// ACTUAL EDITOR CODE FROM HERE...
//----------------------------------------

// Change the current object in the 2darray

hover_text = "";
curobj = obj[currentx,currenty]

// Only gets input if not paused
scr_inputget();

// ------------------------------------
// Selecting objects
// ------------------------------------
var ui_object_nav_x = key_right_pressed - key_left_pressed;

if ui_object_nav_x != 0 {
	xplus = 2 * sign(ui_object_nav_x);
	currenty += sign(ui_object_nav_x);
	
	while currenty < 0 or currenty > maxy or obj[currentx,currenty] == oUndefined or is_undefined(obj[currentx,currenty]){
		currenty += sign(ui_object_nav_x);
		
		if currenty < 0 then 
			currenty = maxy;
		else if currenty > maxy then 
			currenty = 0;
	}
	audio_play_sfx(snd_bump, false, -5, 13);
}

// Update the selected object
curobj = obj[currentx,currenty];

// sprite_index = object_get_sprite(curobj.object)
sprite_index = object_get_sprite(curobj)

// ------------------------------------
// Object rotation and scaling
// ------------------------------------

//if curobj.has_tag("can_flip") {
//	if keyboard_check_pressed(ord("X")) then image_xscale *= -1;
//} else {
//	image_xscale = 1;
//}

if is_mirror_object(curobj) {
	if keyboard_check_pressed(ord("X")) then image_xscale *= -1;
} else {
	image_xscale = 1;
}

//if curobj.has_tag("can_spin") {
//	if keyboard_check_pressed(ord("Z")) {
//		image_angle += 90 
//		if image_angle >= 360 then image_angle = 0;
//	}
//} else {
//	image_xscale = 1;
//}

if is_spin_object(curobj) {
	if keyboard_check_pressed(ord("Z")) and is_in_array(group_canspin,curobj) {
		image_angle += 90 
		if image_angle >= 360 then image_angle = 0
	}
} else {
	image_angle = 0;
}

// ------------------------------------
// Object tile placing calculations
// ------------------------------------
is_cursor_inside_level = 
	global.level_maker_mouse_x > 0
	and global.level_maker_mouse_x < 320
	and global.level_maker_mouse_y > 0
	and global.level_maker_mouse_y < 320;

// var tile_scale = curobj.has_tag("grid_16");
var _tile_scale = is_16_object(curobj) ? 2 : 1;

// var _curobj_sprite = object_get_sprite(curobj.object);
var _curobj_sprite = object_get_sprite(curobj);

var _object_width = 1;
var _object_height = 1;
var _sprite_offset_x = sprite_get_xoffset(_curobj_sprite);
var _sprite_offset_y = sprite_get_yoffset(_curobj_sprite);

var _sprite_offset_x_original = _sprite_offset_x;
var _sprite_offset_y_original = _sprite_offset_y;

//var _size = not is_undefined(curobj) ? curobj.get_size(tile_size) : curobj;
var _size = object_to_size[? curobj];

if(_size != undefined){
	_object_width = _size[0];
	_object_height = _size[1];
	_sprite_offset_x = _size[2];
	_sprite_offset_y = _size[3];
}

var _curobj_mouse_tile_x = round((global.level_maker_mouse_x - _object_width*tile_size div 2) / (_tile_scale*tile_size)) * _tile_scale;
var _curobj_mouse_tile_y = round((global.level_maker_mouse_y - _object_height*tile_size div 2) / (_tile_scale*tile_size)) * _tile_scale;

_curobj_mouse_tile_x = clamp(_curobj_mouse_tile_x,0, room_tile_width - _object_width);
_curobj_mouse_tile_y = clamp(_curobj_mouse_tile_y,0, room_tile_height - _object_height);
//var _sprite_offset = object_sprite_get_offset_typed(curobj);

var _new_offset = rotate_object_offset(_object_width,_object_height,_sprite_offset_x,_sprite_offset_y,image_angle);

_sprite_offset_x = _new_offset[0];
_sprite_offset_y = _new_offset[1];

//placing objects with centered visuals
x = _curobj_mouse_tile_x * tile_size + _sprite_offset_x;
y = _curobj_mouse_tile_y * tile_size + _sprite_offset_y;

//top_left_x = _curobj_mouse_tile_x;
//top_left_y = _curobj_mouse_tile_y;

// Release the button
time += 1;
if time > 6 {
	time = 0; 
	with(oButtonMaker) {
		y = ystart
	}
}

// Check the object that is behind the cursor
place_grid_obj = get_grid_object_hovering(global.level_maker_mouse_x, global.level_maker_mouse_y);

// ------------------------------------
// MOUSE ACTIONS
// ------------------------------------

// If not an eraser, switch between other two cursors.
// Finger if there's an object on the mouse. Cursor otherwise.
if cursor != LEVEL_CURSOR_TYPE.ERASER {
	cursor = place_grid_obj != -1 ? LEVEL_CURSOR_TYPE.FINGER : LEVEL_CURSOR_TYPE.CURSOR;
}

if is_cursor_inside_level {
	if mouse_check_button_pressed(mb_left) 
		and cursor == LEVEL_CURSOR_TYPE.FINGER 
		and is_array(place_grid_obj) 
	{
		var _obj_pos = get_x_y_from_object_index(place_grid_obj[2]);
				
		currentx = _obj_pos[0];
		currenty = _obj_pos[1];
				
		remove_object_from_grid(place_grid_obj);
	}

	//Create Instance
	if mouse_check_button_released(mb_left)
		and cursor == LEVEL_CURSOR_TYPE.CURSOR 
		and not check_for_objects_in_grid_position(_curobj_mouse_tile_x, _curobj_mouse_tile_y, curobj)
		and (curobj != oUndefined or not is_undefined(curobj))
	{
		// if curobj.has_tag("player") {
		if is_player_object(curobj) {
			remove_all_player_objects_from_grid();
		}
		
		// if curobj.object == oMagicOrb or curobj.object == oGrayOrb
		if curobj == oMagicOrb or curobj == oGrayOrb {
			remove_orb_from_grid();
		}
		
		//instance_create_layer(x,y,"Instances",curobj,{image_xscale: oLevelMaker.image_xscale, image_angle: oLevelMaker.image_angle})
		place_object_in_object_grid(_curobj_mouse_tile_x, _curobj_mouse_tile_y, curobj, oLevelMaker.image_xscale, oLevelMaker.image_angle);
		
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
		and is_array(place_grid_obj) 
	{
		remove_object_from_grid(place_grid_obj);
		
		audio_play_sfx(snd_brokestone,false,-5,15);
		instance_create_layer(x + 8, y + 8, "Instances_2", oBigSmoke);
		instance_create_layer(x + 8, y + 8, "Instances_2", oBigSmoke);
	}
}
