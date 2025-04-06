/* NOTES:

- This repository is based on Moonleap version 2.3.2, but with the SleepScreens removed and some levels missing, specifically Rooms 0 to 49.
- Rooms 60 to 63 were kept only as examples of how the levels in Moonleap were originally built.
- The maker_mode=true setting in the oIntro causes the game go straight to the RoomMaker0

- Some objects just didnt pause when oPause exists, thats a bug
- oSolidDay and oSolidNight were created for this levelmaker, in the game i use oGrassDay, oGrassNight, oCloudDay...
- [DONE!] the UI show plenty of oUndefined, it isn't ideal, need to do a solution for that
- Style stuff isn't done yet but the way enemies check what style of phase they are in is by checking if there is a GrassDay, CloudDay, FlowerDay and so on
based on that they update their colors
- oPlatGhost dont really rotate, in the game i use oPlatGhostL, oPlatGhostR and oPlatGhostInv...
- The plan is to eventually integrate Moonleap Maker into the Steam version of Moonleap, making it available as an option in the game menu

*/

// Input variables
scr_inputcreate()

// Grid-related
tile_size = 8;
room_tile_width =  room_width div tile_size;
room_tile_height = (room_height div tile_size) + tile_size;
objects_grid = []; // Grid where the objects inserted by player are.

for(var _x = 0; _x < room_tile_width; _x++){
	for(var _y = 0; _y < room_tile_height; _y++){
		objects_grid[_x,_y] = -1;
	}	
}

// Cursor-related
cursor = LEVEL_CURSOR_TYPE.NOTHING;
cursor_object_hovering = undefined;
is_cursor_inside_level = false;
item_preview_offset_x = 0;
item_preview_offset_y = 0;
has_object_below_cursor = false;
test_button_cooldown_max = 20;
test_button_cooldown = test_button_cooldown_max;
reset_test_button_cooldown = function() {
	test_button_cooldown = test_button_cooldown_max;
}

// Level-related
selected_style = LEVEL_STYLE.GRASS;
//time = 0; //used to release the buttons

// UI-related
hover_text = "";
text_shadow_x = 2;
text_shadow_y = 1;
color = {
	nice_black: make_color_rgb(0,0,72),
	nice_white: make_color_rgb(170,255,255),
	nice_blue: $FFFFAA55,
};

// Objects-related
selected_object = 0;
selected_object_type = 0;
selected_object_position = 0;
default_sprite_origin = SPRITE_ORIGIN.TOP_LEFT;
object_positions_length = 16;
object_grid_hovering = -1; // Object where cursor is above at.

// Objects List
obj[0, 00] =	new LMObject(oPlayer,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_player");
obj[0, 01] =	new LMObject(oSolid,			16, 16).add_tag("grid_16", "is_holdable");
obj[0, 02] =	new LMObject(oBrokenStone,		16, 16).add_tag("grid_16", "is_holdable");
obj[0, 03] =	new LMObject(oPermaSpike,		16, 16).add_tag("is_holdable");
obj[0, 04] =	new LMObject(oStar,				16, 16).add_tag("can_spin");
obj[0, 05] =	new LMObject(oStarRunning,		16, 16);
obj[0, 06] =	new LMObject(oSolidDay,			16, 16, SPRITE_ORIGIN.OFFSET5).add_tag("grid_16", "is_holdable");
obj[0, 07] =	new LMObject(oSolidNight,		16, 16, SPRITE_ORIGIN.OFFSET5).add_tag("grid_16", "is_holdable");
obj[0, 08] =	new LMObject(oLadderDay,		16, 16);
obj[0, 09] =	new LMObject(oLadderNight,		16, 16);
obj[0, 10] =	new LMObject(oSnail,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip").set_sprite_button_part(sSnailWalk, 0, 0, 2, -9, 0);
obj[0, 11] =	new LMObject(oSnailNight,		16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip").set_sprite_button_part(sSnailIdleNight, 0, 0, 2, -11, 0, 18);
obj[0, 12] =	new LMObject(oLady,				16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_spin", "can_flip");
obj[0, 13] =	new LMObject(oBat,				16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip", "grid_16").set_sprite_button_part(sBat, 0, 10, 4, -7, -8);
obj[0, 14] =	new LMObject(oPlatGhost,		16, 16).add_tag("can_spin");
obj[0, 15] =	new LMObject(oSolidRamp,		32, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBlockRampEditor, 0, 16, 0, -8, -8);

obj[1, 00] =	new LMObject(oPlayerDir,		16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_player");
obj[1, 01] =	new LMObject(oBigSolid,			32, 32).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBlockGrayGiant, 0, 0, 0, 0, 0);
obj[1, 02] =	new LMObject(oBrokenStoneBig,	32, 32).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBrokenStoneBig, 0, 0, 0, 0, 0);
obj[1, 03] =	new LMObject(oStarColor,		16, 16);
obj[1, 04] =	new LMObject(oStarRunningColor,	16, 16);
obj[1, 05] =	new LMObject(oLadderNeutral,	16, 16);
obj[1, 06] =	new LMObject(oSnailGray,		16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip");
obj[1, 07] =	new LMObject(oLadyGray,			16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_spin", "can_flip");
obj[1, 08] =	new LMObject(oBatVer,			16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBatDown, 0, 10, 4, -7, -8);
obj[1, 09] =	new LMObject(oMush,				16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_spin");
obj[1, 10] =	new LMObject(oMushGray,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_spin").set_sprite_button_part(sMushGrayUI, 0, 0, 0, 0, 0);
obj[1, 11] =	new LMObject(oBird,				16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip");
obj[1, 12] =	new LMObject(oLadyGiant,		48, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sLadyGiant, 0, 19, 1, -8, -8);
obj[1, 13] =	new LMObject(oLadyGiant4,		64, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sLadyGiant4, 0, 14, 1, -8, -8);
obj[1, 14] =	new LMObject(oBatGiant,			48, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBatGiant, 0, 21, 1, -8, -8);
obj[1, 15] =	new LMObject(oBatSuperGiant,	64, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBatGiant4, 0, 12, 1, -8, -8);

obj[2, 00] =	new LMObject(oPlayerNeutral,	16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_player");
obj[2, 01] =	new LMObject(oMagicOrb,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_orb");
obj[2, 02] =	new LMObject(oStarFly,			16, 16);
obj[2, 03] =	new LMObject(oKey,				16, 16);
obj[2, 04] =	new LMObject(oKeyDoor,			16, 16);
obj[2, 05] =	new LMObject(oKeyTall,			32, 16).set_sprite_button_part(sKeyDoorTallUI, 0, 0, 8, -8, -8);
obj[2, 06] =	new LMObject(oKeyDoorTall,		32, 16).set_sprite_button_part(sKeyDoorTall, 0, 0, 8, -8, -8);
obj[2, 07] =	new LMObject(oKeyWide,			32, 16).set_sprite_button_part(sKeyDoorWideUI, 0, 8, 0, -8, -8);
obj[2, 08] =	new LMObject(oKeyDoorWide,		32, 16).set_sprite_button_part(sKeyDoorWide, 0, 8, 0, -8, -8);
obj[2, 09] =	new LMObject(oKeyTallWide,		32, 32).set_sprite_button_part(sKeyDoorTallWideUI, 0, 0, 0, -8, -8);
obj[2, 10] =	new LMObject(oKeyDoorTallWide,	32, 32).set_sprite_button_part(sKeyDoorWideTall, 0, 0, 0, -8, -8);
obj[2, 11] =	new LMObject(oSolidInv,			16, 16).add_tag("grid_16", "is_holdable");
obj[2, 12] =	new LMObject(oBlack,			16, 16).add_tag("grid_16", "is_holdable");
obj[2, 13] =	new LMObject(oPlatGhostL,		16, 16);
obj[2, 14] =	new LMObject(oPlatGhostR,		16, 16);
obj[2, 15] =	new LMObject(oPlatGhostInv,		16, 16);

//obj[3, 00] =	new LMObject(oSolid,			16, 16).add_tag("grid_16", "is_holdable");
//obj[3, 01] =	new LMObject(oSolid,			16, 16).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBlockGray, 1, 0, 0, 0, 0).set_object_config(1);
//obj[3, 02] =	new LMObject(oSolid,			16, 16).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBlockGray, 2, 0, 0, 0, 0).set_object_config(2);
//obj[3, 03] =	new LMObject(oBigSolid,			32, 32).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBlockGrayGiant, 0, 0, 0, 0, 0);
//obj[3, 04] =	new LMObject(oBigSolid,			32, 32).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBlockGrayGiant, 1, 0, 0, 0, 0).set_object_config(1);
//obj[3, 05] =	new LMObject(oBigSolid,			32, 32).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBlockGrayGiant, 2, 0, 0, 0, 0).set_object_config(2);
//obj[3, 06] =	new LMObject(oBrokenStone,		16, 16).add_tag("grid_16", "is_holdable");
//obj[3, 07] =	new LMObject(oBrokenStoneBig,	32, 32).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBrokenStoneBig, 0, 0, 0, 0, 0);
//obj[3, 08] =	undefined;
//obj[3, 09] =	undefined;
//obj[3, 10] =	undefined;
//obj[3, 11] =	undefined;
//obj[3, 12] =	undefined;
//obj[3, 13] =	undefined;
//obj[3, 14] =	undefined;
//obj[3, 15] =	undefined;

object_types_length = array_length(obj);

////x0 mostly neutral	//x1 mostly day				//x2 mostly night			//x3								//x4 unused, i plan to make stars fly with they werent colliding
//obj[0,0]=oPlayer		obj[1,0]=oPlayerDir			obj[2,0]=oPlayerNeutral		obj[3,0]=oUndefined				obj[4,0]=oUndefined
//obj[0,1]=oSolid			obj[1,1]=oSolidDay			obj[2,1]=oSolidNight		obj[3,1]=oBigSolid				obj[4,1]=oUndefined
//obj[0,2]=oPlatGhost		obj[1,2]=oBrokenStone		obj[2,2]=oBrokenStoneBig	obj[3,2]=oSolidRamp/**/			obj[4,2]=oUndefined
//obj[0,3]=oPermaSpike	obj[1,3]=oUndefined			obj[2,3]=oUndefined			obj[3,3]=oUndefined/**/			obj[4,3]=oUndefined
//obj[0,4]=oStar			obj[1,4]=oStarColor			obj[2,4]=oStarRunning		obj[3,4]=oStarRunningColor		obj[4,4]=oStarFly
//obj[0,5]=oLadderNeutral obj[1,5]=oLadderDay			obj[2,5]=oLadderNight		obj[3,5]=oUndefined/**/			obj[4,5]=oPlatGhostL
//obj[0,6]=oSnailGray		obj[1,6]=oSnail				obj[2,6]=oSnailNight		obj[3,6]=oUndefined/**/			obj[4,6]=oPlatGhostR
//obj[0,7]=oLadyGray		obj[1,7]=oLady				obj[2,7]=oLadyGiant			obj[3,7]=oLadyGiant4			obj[4,7]=oPlatGhostInv
//obj[0,8]=oBat			obj[1,8]=oBatGiant			obj[2,8]=oUndefined			obj[3,8]=oUndefined/*baixo*/	obj[4,8]=oNeutralFlag
//obj[0,9]=oMushGray		obj[1,9]=oMush				obj[2,9]=oMushGray			obj[3,9]=oUndefined				obj[4,9]=oUndefined
////obj[0,10]=oUndefined	obj[1,10]=oUndefined		obj[2,10]=oUndefined		obj[3,10]=oUndefined			obj[4,10]=oUndefined
//obj[0,10]=oKey			obj[1,10]=oKeyTall			obj[2,10]=oKeyWide			obj[3,10]=oKeyTallWide			obj[4,10]=oUndefined //make different spr to differentiate the keys
//obj[0,11]=oKeyDoor		obj[1,11]=oKeyDoorTall		obj[2,11]=oKeyDoorWide		obj[3,11]=oKeyDoorTallWide		obj[4,11]=oUndefined
//obj[0,12]=oGrayOrb		obj[1,12]=oMagicOrb			obj[2,12]=oUndefined		obj[3,12]=oUndefined			obj[4,12]=oUndefined
//obj[0,13]=oBird			obj[1,13]=oUndefined		obj[2,13]=oUndefined		obj[3,13]=oUndefined			obj[4,13]=oUndefined
//obj[0,14]=oBlack		obj[1,14]=oUndefined		obj[2,14]=oUndefined		obj[3,14]=oUndefined			obj[4,14]=oUndefined
//obj[0,15]=oUndefined	obj[1,15]=oUndefined		obj[2,15]=oUndefined		obj[3,15]=oUndefined			obj[4,15]=oUndefined

get_lmobject_from_list = function(_object_index) {
	for(var t = 0; t < array_length(obj); t++) {
		var type = obj[t];
		
		for(var p = 0; p < array_length(type); p++) {
			if type[p].index == _object_index then return type[p];
		}
	}
}

get_x_y_from_object_index = function(_object) {
	for (var yy = object_positions_length - 1; yy >= 0; yy--) {
		for (var xx = object_types_length - 1; xx >= 0; xx--) {
			var object_from_list = obj[xx, yy];
			
			if is_undefined(object_from_list) then continue;
			
			if (object_from_list.index == _object.index) {
				return [xx, yy];
			}
		}
	}
}

rotate_object_offset = function(_object_width, _object_height, _sprite_offset_x, _sprite_offset_y, _angle){
	var _half_width_object = (_object_width * tile_size) div 2;
	var _half_height_object = (_object_height * tile_size) div 2;
	
	_sprite_offset_x -= _half_width_object;
	_sprite_offset_y -= _half_height_object;
	
	var _dist = point_distance(0,0,_sprite_offset_x,_sprite_offset_y);
	var _dir = point_direction(0,0,_sprite_offset_x,_sprite_offset_y);
	
	_sprite_offset_x = lengthdir_x(_dist,_dir+_angle);
	_sprite_offset_y = lengthdir_y(_dist,_dir+_angle);
	
	_sprite_offset_x += _half_width_object;
	_sprite_offset_y += _half_height_object;
	
	return [_sprite_offset_x,_sprite_offset_y];
}

get_grid_object_hovering = function(_mouse_x, _mouse_y){
	for(var _x = 0; _x < room_tile_width; _x++){
		for(var _y = 0; _y < room_tile_height; _y++){
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			
			if is_struct(_object_grid) 
				and _top_left_x == _x
				and _top_left_y == _y
			{
				
				var _w = _object_grid.object_width;
				var _h = _object_grid.object_height;
				
				if point_in_rectangle(_mouse_x, _mouse_y, _x*tile_size,_y*tile_size, (_x+_w)*tile_size, (_y+_h)*tile_size) {
					return _object_grid;
				}
			}
		}	
	}
	return -1;
}

place_object_in_object_grid = function(_top_left_x, _top_left_y, _object, _xscale = 1, _angle = 0){
	var _object_width = 1;
	var _object_height = 1;

	var _tiled_size = _object.get_size(tile_size);

	_object_width = _tiled_size[0];
	_object_height = _tiled_size[1];
	
	var _object_grid = new LMObjectGrid(
		_top_left_x,
		_top_left_y,
		_object,
		_object_width,
		_object_height,
		_xscale,
		_angle
	);
	
	//var _object_data = [
	//	_top_left_x,
	//	_top_left_y,
	//	_object,
	//	_object_width,
	//	_object_height,
	//	_xscale,
	//	_angle
	//];
	
	//make sure the object stays inside the grid
	_top_left_x = clamp(_top_left_x, 0, room_tile_width - _object_width);
	_top_left_y = clamp(_top_left_y, 0, room_tile_height - _object_height);
	
	for(var _x = _top_left_x; _x < _top_left_x + _object_width; _x++){
		for(var _y = _top_left_y; _y < _top_left_y + _object_height; _y++) {
			objects_grid[_x, _y] = _object_grid;
		}	
	}
}

remove_object_from_grid = function(_object_grid){
	var _top_left_x = _object_grid.top_left_x;
	var _top_left_y = _object_grid.top_left_y;
	
	var _object_width = _object_grid.object_width;
	var _object_height = _object_grid.object_height;
	
	for(var _x = _top_left_x; _x < _top_left_x + _object_width; _x++) {
		for(var _y = _top_left_y; _y < _top_left_y + _object_height; _y++) {
			objects_grid[_x, _y] = -1;
		}	
	}
}

check_for_objects_in_grid_position = function(_top_left_x, _top_left_y, _object) {
	if _object == undefined then return false;
	
	var _object_width = 1;
	var _object_height = 1;
	var _size = _object.get_size(tile_size);

	_object_width = _size[0];
	_object_height = _size[1];
	
	//make sure the object stays inside the grid
	_top_left_x = clamp(_top_left_x,0, room_tile_width - _object_width);
	_top_left_y = clamp(_top_left_y,0, room_tile_height - _object_height);
	
	for(var _x = _top_left_x; _x < _top_left_x+_object_width; _x++){
		for(var _y = _top_left_y; _y < _top_left_y+_object_height; _y++){
			var _object_grid = objects_grid[_x, _y];
			
			if is_struct(_object_grid) then return true;
		}	
	}
	
	return false;
}

remove_all_player_objects_from_grid = function() {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x, _y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			var _object_index = _object_grid.object;
			
			if is_struct(_object_grid)
				and _top_left_x == _x 
				and _top_left_y == _y 
				and _object_index.has_tag("is_player") 
			{
				remove_object_from_grid(_object_grid);
			}
		}
	}
}

remove_orb_from_grid = function() {
	for(var _x = 0; _x < room_tile_width; _x++){
		for(var _y = 0; _y < room_tile_height; _y++){
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			var _object_index = _object_grid.object;
			
			if is_struct(_object_grid)
				and _top_left_x == _x
				and _top_left_y == _y
				and (_object_grid.object.index == oMagicOrb 
					or _object_grid.object.index == oGrayOrb)
			{
				remove_object_from_grid(_object_grid);
			}
		}
	}
}

object_of_type_exists_in_editor = function(_object_index) {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			if is_struct(_object_grid)
				and _object_grid.object.index == _object_index then
				return true;
		}
	}
	
	return false;
}

start_level = function() {
	audio_play_sfx(sndStarGame,false,-18.3,1)
	hover_text = "";
	
	instance_destroy(oPause);
	
	switch (selected_style) {
		case LEVEL_STYLE.GRASS:		instance_create_layer(0, 0,"Instances", o_grass_song);		break;
		case LEVEL_STYLE.CLOUDS:	instance_create_layer(0, 0,"Instances", o_cloud_song);		break;
		case LEVEL_STYLE.FLOWERS:	instance_create_layer(0, 0,"Instances", o_flower_song);		break;
		case LEVEL_STYLE.SPACE:		instance_create_layer(0, 0,"Instances", o_space_song);		break;
		case LEVEL_STYLE.DUNGEON:	instance_create_layer(0, 0,"Instances", o_dungeon_song);	break;
	}
	
	// Instantiate all objects on the level
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			
			if is_struct(_object_grid)
				and _top_left_x == _x 
				and _top_left_y == _y
			{
				var _object = _object_grid.object;
				var _xscale = _object_grid.xscale;
				var _angle = _object_grid.angle;
				
				var _sprite = object_get_sprite(_object.index);
				var _object_width = 1;
				var _object_height = 1;
				var _sprite_offset_x = sprite_get_xoffset(_sprite);
				var _sprite_offset_y = sprite_get_yoffset(_sprite);
				var _size = _object.get_size(tile_size);

				_object_width = _size[0];
				_object_height = _size[1];
				_sprite_offset_x = _size[2];
				_sprite_offset_y = _size[3];
			
				var _new_offset = rotate_object_offset(_object_width, _object_height, _sprite_offset_x, _sprite_offset_y, _angle);
				
				_sprite_offset_x = _new_offset[0];
				_sprite_offset_y = _new_offset[1];

				var _in_world_x = _x * tile_size + _sprite_offset_x;
				var _in_world_y = _y * tile_size + _sprite_offset_y;
				
				_in_world_x = round(_in_world_x);
				_in_world_y = round(_in_world_y);
				
				var _layer_name = "GimmickInstances";
				
				if _object.has_tag("is_player") or _object.has_tag("is_orb") then _layer_name = "PlayerInstances";
				
				var _object_in_world = instance_create_layer(_in_world_x, _in_world_y, _layer_name, _object.index, {
					image_xscale: _xscale,
					image_angle: _angle
				});
				
				if not is_undefined(_object.object_config) {
					var config = _object.object_config;
					with(_object_in_world) {
						image_index = config.image_index;
					}
				}
			}
		}
	}
	
	
	with(oLevelMaker) {
		scr_update_style()
	}
	//game_save("level.savetemp")
	
	with (oBrokenStone)
	{
		brokenright = instance_place(x+1,y,oBrokenStone)
		brokenleft = instance_place(x-1,y,oBrokenStone)
		brokenup = instance_place(x,y-1,oBrokenStone)
		brokendown = instance_place(x,y+1,oBrokenStone)
	}
}

delete_all_objects_from_level = function() {
	for (var yy = object_positions_length - 1; yy>=0; yy-=1) {
		for (var xx = object_types_length - 1; xx>=0; xx-=1) {
			var object = obj[xx, yy];
			
			if is_undefined(obj[xx, yy]) then continue;
			instance_destroy(object.index, false);
		}
	}
}

end_level_and_return_to_editor = function(){
	//destroy the "song"
	instance_destroy(o_grass_song);
	instance_destroy(o_cloud_song);
	instance_destroy(o_flower_song);
	instance_destroy(o_space_song);
	instance_destroy(o_dungeon_song);
	audio_stop_all()
	
	delete_all_objects_from_level();
	instance_create_layer(x,y,layer,oPause);
	
	// Reset day/night state
	if instance_exists(oCamera) then
		oCamera.night = false;
	
	// Destroy gimmicks that would persist on level editor after playtest
	instance_destroy(oNeutralFlag);
	instance_destroy(oKeyFollow);
	instance_destroy(oKeyFollow2);
	instance_destroy(oKeyFollow3);
	
	audio_play_sfx(snd_bump, false, 1, 1);
	just_entered_level_editor = true;
}

//CAMERA CODE

oCamera.fancyeffects = false;

camera_current_interpolation = 0;

global.level_maker_mouse_x = mouse_x;
global.level_maker_mouse_y = mouse_y;

just_entered_level_editor = false;

instance_create_layer(x,y,layer,oPause);

//----------------------
// DEFAULT LEVEL

// floor
var fi = 0;
repeat(6) {
	place_object_in_object_grid(14 + 2 * fi, 14, get_lmobject_from_list(oSolid));
	fi++;
}

// player
place_object_in_object_grid(16, 12, get_lmobject_from_list(oPlayer));

// star
place_object_in_object_grid(22, 12, get_lmobject_from_list(oStar));
