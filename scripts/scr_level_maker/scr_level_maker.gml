enum LEVEL_CURRENT_LAYER { FOREGROUND, OBJECTS, BACKGROUND_1, BACKGROUND_2, BACKGROUND_3 }
enum LEVEL_CURSOR_TYPE { NOTHING, CURSOR, FINGER, ERASER }
enum LEVEL_STYLE { GRASS, CLOUDS, FLOWERS, SPACE, DUNGEON,LENGTH }
enum SPRITE_ORIGIN { TOP_LEFT, CENTER, BOTTOM, OFFSET5 }

/// @description A "Level Maker Object" constructor. Use this as base to create
/// an object for the level editor.
/// @param {Asset.GMObject} _object_index The matching object index of the level object.
/// @param {real} _object_size_x The horizontal size this object will occupy on the level grid.
/// @param {real} _object_size_y The vertical size this object will occupy on the level grid.
/// @param {real} _origin_type The origin type to position the object sprite on level grid.
/// Use one of the SPRITE_ORIGIN enumerator values to set it.
function LMObject(_object_index, _object_size_x, _object_size_y, _origin_type = SPRITE_ORIGIN.TOP_LEFT) constructor {
	label = "";
	index = _object_index;
	size_x = _object_size_x;
	size_y = _object_size_y;
	origin_type = _origin_type;
	tags = [];
	object_config = undefined;
	
	preview_image_index_vertical = undefined;
	
	sprite_button_sprite_index = undefined;
	sprite_button_image_index = 0;
	sprite_button_x_offset = 0;
	sprite_button_y_offset = 0;
	sprite_button_part_left = 0;
	sprite_button_part_top = 0;
	sprite_button_part_width = 16;
	sprite_button_part_height = 16;
	
	set_preview_index_vertical = function(_image_index_flipped = 0) {
		preview_image_index_vertical = _image_index_flipped;
		return self;
	}
	
	set_sprite_button_part = function(
		new_sprite_index,
		new_image_index,
		left_position,
		top_position,
		x_offset, 
		y_offset,
		width = undefined,
		height = undefined
	) {
		sprite_button_sprite_index = new_sprite_index;
		sprite_button_image_index = new_image_index;
		sprite_button_part_left = left_position;
		sprite_button_part_top = top_position;
		sprite_button_x_offset = x_offset;
		sprite_button_y_offset = y_offset;
		sprite_button_part_width = is_undefined(width) ? sprite_button_part_width : width;
		sprite_button_part_height = is_undefined(height) ? sprite_button_part_height : height;
		return self;
	}
	
	set_object_config = function(_object_config) {
		if not is_struct(_object_config) then
			throw "Object config must be a struct of object variables names as keys.";
		
		object_config = _object_config;
		return self;
	}
	
	draw_sprite_button_part = function(_x, _y) {
		var sprite = sprite_button_sprite_index;
		var sprite_nineslice = sprite_get_nineslice(sprite);
		var prev_nineslice_enabled = sprite_nineslice.enabled;
		
		sprite_nineslice.enabled = false;
		draw_sprite_part(sprite, sprite_button_image_index, sprite_button_part_left, sprite_button_part_top, sprite_button_part_width, sprite_button_part_height, _x + sprite_button_x_offset, _y + sprite_button_y_offset);
		sprite_nineslice.enabled = prev_nineslice_enabled;
	}
	
	add_tag = function() {
		var i = 0;
		
		repeat(argument_count) {
			var _tag = argument[i]
			
			if typeof(_tag) != "string" then throw ("A tag must be a string.");
			array_push(tags, _tag);
			i++;
		}
		
		return self;
	}
	
	has_tag = function(_tag) {
		return array_find_index(tags, _tag) == -1 ? false : true;
	}
	
	/// @desc Gets the x and y position of the object's sprite origin depending of its origin type.
	/// @returns {Array<real>} Array of x and y position of the sprite origin respectively.
	get_sprite_offset_typed = function(_tile_size, _object_tile_width, _object_tile_height) {
		var _sprite = object_get_sprite(index);
		var _offx = sprite_get_xoffset(_sprite);
		var _offy = sprite_get_yoffset(_sprite);
		var _w = sprite_get_width(_sprite);
		var _h = sprite_get_height(_sprite);
		
		switch(origin_type){
			case SPRITE_ORIGIN.OFFSET5:
				return [
					_offx - 8,
					_offy - 8
				];
			case SPRITE_ORIGIN.TOP_LEFT:
				return [
					_offx,
					_offy
				];
			case SPRITE_ORIGIN.BOTTOM:
				return [
					_offx - _w / 2 + _object_tile_width * _tile_size / 2,
					_offy - _h + _object_tile_height * _tile_size,
				];
			case SPRITE_ORIGIN.CENTER:
				return [
					_offx - _w / 2 + _object_tile_width * _tile_size / 2,
					_offy - _h / 2 + _object_tile_height * _tile_size / 2
				];
		}
	}
	
	get_size = function(_tile_size = 8) {
		var _tiled_width = size_x / _tile_size;
		var _tiled_height = size_y / _tile_size;
		
		var _offset = get_sprite_offset_typed(_tile_size, _tiled_width, _tiled_height);
		
		return [_tiled_width, _tiled_height, _offset[0], _offset[1]];
	}
	
	return self;
}

/// @param {real} _top_left_x
/// @param {real} _top_left_y
/// @param {Asset.GMObject} _object
/// @param {real} _object_width
/// @param {real} _object_height
/// @param {real} _xscale
/// @param {real} _yscale
/// @param {real} _angle
function LMObjectGrid(_top_left_x, _top_left_y, _object, _object_width, _object_height, _xscale, _yscale, _angle) constructor {
	top_left_x = _top_left_x;
	top_left_y = _top_left_y;
	object = _object;
	object_width = _object_width;
	object_height = _object_height;
	xscale = _xscale;
	yscale = _yscale;
	angle = _angle;
}

function LMTile(_tile_id) constructor {
	tile_id = _tile_id;
	tile_frames_id = [];
	tile_frames_fps = 8;
	tileset = undefined;
	
	can_change = false;
	
	set_tileset = function(_tileset) {
		tileset = _tileset;
	}
	
	set_tile_frames = function(_tile_frames_id) {
		tile_frames_id = _tile_frames_id;
	}
	
	draw_sprite_preview = function(_x, _y) {
		draw_tile(tileset, tile_id, 0, _x, _y);
		if can_change then
			draw_sprite(sMakerChangeIcon, 0, _x + 16, _y + 16);
	}
}

function level_maker_get_objects_list() {
	var _obj = [];
	
	_obj[0, 00] =	new LMObject(oPlayer,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_unique");
	_obj[0, 01] =	new LMObject(oSolid,			16, 16).add_tag("grid_16", "is_holdable");
	_obj[0, 02] =	new LMObject(oBrokenStone,		16, 16).add_tag("grid_16", "is_holdable");
	_obj[0, 03] =	new LMObject(oPermaSpike,		16, 16).add_tag("is_holdable");
	_obj[0, 04] =	new LMObject(oStar,				16, 16).add_tag("can_spin");
	_obj[0, 05] =	new LMObject(oStarRunning,		16, 16);
	_obj[0, 06] =	new LMObject(oSolidDay,			16, 16, SPRITE_ORIGIN.OFFSET5).add_tag("grid_16", "is_holdable");
	_obj[0, 07] =	new LMObject(oSolidNight,		16, 16, SPRITE_ORIGIN.OFFSET5).add_tag("grid_16", "is_holdable");
	_obj[0, 08] =	new LMObject(oLadderDay,		16, 16);
	_obj[0, 09] =	new LMObject(oLadderNight,		16, 16);
	_obj[0, 10] =	new LMObject(oSnail,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip").set_sprite_button_part(sSnailWalk, 0, 0, 2, -9, 0);
	_obj[0, 11] =	new LMObject(oSnailNight,		16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip").set_sprite_button_part(sSnailIdleNight, 0, 0, 2, -11, 0, 18);
	_obj[0, 12] =	new LMObject(oLady,				16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip");
	_obj[0, 13] =	new LMObject(oBat,				16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip", "grid_16").set_sprite_button_part(sBat, 0, 10, 4, -7, -8);
	_obj[0, 14] =	new LMObject(oPlatGhost,		16, 16).add_tag("can_spin");
	_obj[0, 15] =	new LMObject(oSolidRamp,		32, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBlockRampEditor, 0, 16, 0, -8, -8);
	
	_obj[1, 00] =	new LMObject(oPlayerDir,		16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_player");
	_obj[1, 01] =	new LMObject(oBigSolid,			32, 32).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBlockGrayGiant, 0, 0, 0, 0, 0);
	_obj[1, 02] =	new LMObject(oBrokenStoneBig,	32, 32).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBrokenStoneBig, 0, 0, 0, 0, 0);
	_obj[1, 03] =	new LMObject(oStarColor,		16, 16);
	_obj[1, 04] =	new LMObject(oStarRunningColor,	16, 16);
	_obj[1, 05] =	new LMObject(oLadderNeutral,	16, 16);
	_obj[1, 06] =	new LMObject(oSnailGray,		16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip");
	_obj[1, 07] =	new LMObject(oLadyGray,			16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sLadyGrayUI, 0, 3, 0, -8, -8);
	_obj[1, 08] =	new LMObject(oBatVer,			16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip", "grid_16", "is_vertical").set_preview_index_vertical(1).set_sprite_button_part(sBatDown, 0, 10, 4, -7, -8);
	_obj[1, 09] =	new LMObject(oMush,				16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_spin");
	_obj[1, 10] =	new LMObject(oMushGray,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_spin").set_sprite_button_part(sMushGrayUI, 0, 0, 0, 0, 0);
	_obj[1, 11] =	new LMObject(oLadyVer,			16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip", "is_vertical").set_sprite_button_part(sLadyVerUI, 0, 3, 1, -8, -8);
	_obj[1, 12] =	new LMObject(oLadyGiant,		48, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sLadyGiant, 0, 19, 1, -8, -8);
	_obj[1, 13] =	new LMObject(oLadyGiant4,		64, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sLadyGiant4, 0, 14, 1, -8, -8);
	_obj[1, 14] =	new LMObject(oBatGiant,			48, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBatGiant, 0, 21, 1, -8, -8);
	_obj[1, 15] =	new LMObject(oBatSuperGiant,	64, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBatGiant4, 0, 12, 1, -8, -8);
	
	_obj[2, 00] =	new LMObject(oPlayerNeutral,	16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_unique");
	_obj[2, 01] =	new LMObject(oMagicOrb,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_unique");
	_obj[2, 02] =	new LMObject(oStarFly,			16, 16);
	_obj[2, 03] =	new LMObject(oBird,				16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip", "is_unique");
	_obj[2, 04] =	new LMObject(oSolidInv,			16, 16).add_tag("grid_16", "is_holdable");
	_obj[2, 05] =	new LMObject(oKey,				16, 16);
	_obj[2, 06] =	new LMObject(oKeyDoor,			16, 16);
	_obj[2, 07] =	new LMObject(oKeyTall,			32, 16).set_sprite_button_part(sKeyDoorTallUI, 0, 0, 8, -8, -8);
	_obj[2, 08] =	new LMObject(oKeyDoorTall,		32, 16).set_sprite_button_part(sKeyDoorTall, 0, 0, 8, -8, -8);
	_obj[2, 09] =	new LMObject(oKeyWide,			32, 16).set_sprite_button_part(sKeyDoorWideUI, 0, 8, 0, -8, -8);
	_obj[2, 10] =	new LMObject(oKeyDoorWide,		32, 16).set_sprite_button_part(sKeyDoorWide, 0, 8, 0, -8, -8);
	_obj[2, 11] =	new LMObject(oKeyTallWide,		32, 32).set_sprite_button_part(sKeyDoorTallWideUI, 0, 0, 0, -8, -8);
	_obj[2, 12] =	new LMObject(oKeyDoorTallWide,	32, 32).set_sprite_button_part(sKeyDoorWideTall, 0, 0, 0, -8, -8);
	_obj[2, 13] =	undefined;
	_obj[2, 14] =	undefined;
	_obj[2, 15] =	undefined;
	
	return _obj;
}

function level_maker_get_background_layer_name() {
	switch(oLevelMaker.current_layer) {
		case LEVEL_CURRENT_LAYER.FOREGROUND:
			return "Tiles_Foreground";
		case LEVEL_CURRENT_LAYER.BACKGROUND_1:
			return "Tiles_Background1";
		case LEVEL_CURRENT_LAYER.BACKGROUND_2:
			return "Tiles_Background2";
		case LEVEL_CURRENT_LAYER.BACKGROUND_3:
			return "Tiles_Background3";
		default:
			return -1;
	}
}

function level_maker_get_layer_hover_text() {
	switch(oLevelMaker.current_layer) {
		case LEVEL_CURRENT_LAYER.FOREGROUND:
			return "Foreground";
		case LEVEL_CURRENT_LAYER.BACKGROUND_1:
			return "Background 1";
		case LEVEL_CURRENT_LAYER.BACKGROUND_2:
			return "Background 2";
		case LEVEL_CURRENT_LAYER.BACKGROUND_3:
			return "Background 3";
		case LEVEL_CURRENT_LAYER.OBJECTS:
			return "Objects";
		default:
			return "Unknown";
	}
}

function level_maker_get_tiles_list() {
	var _tiles_list = []; // result of the list
	var _tileset = undefined;
	var _tiles_amount = 0; // the amount of tiles the matching tileset has
	var _tile_changes_starts_from = 0;
	var _pages = 1;
	var c_tile_id = 0;
	
	switch(oLevelMaker.selected_style) {
		case LEVEL_STYLE.GRASS:
			_tileset = tMakerGrassDay;
			_pages = 4;
			_tiles_amount = 56;
			_tile_changes_starts_from = 38;
			break;
		case LEVEL_STYLE.CLOUDS:
			_tileset = tMakerCloudDay;
			_pages = 4;
			_tiles_amount = 61;
			_tile_changes_starts_from = 37;
			break;
		case LEVEL_STYLE.FLOWERS:
			_tileset = tMakerFlowerDay;
			_pages = 2;
			_tiles_amount = 33;
			_tile_changes_starts_from = 14;
			break;
		case LEVEL_STYLE.SPACE:
			_tileset = tMakerSpaceDay;
			_pages = 4;
			_tiles_amount = 53;
			_tile_changes_starts_from = 34;
			break;
		case LEVEL_STYLE.DUNGEON:
			_tileset = tMakerDungeonDay;
			_pages = 4;
			_tiles_amount = 57;
			_tile_changes_starts_from = 45;
			break;
	}
	
	for (var t = 0; t < _pages; t++) {
		for (var p = 0; p < 16; p++) {
			c_tile_id++
			
			while c_tile_id == 0 {
				c_tile_id++;
			}
			
			if c_tile_id >= _tiles_amount {
				_tiles_list[t, p] = undefined;
				continue;
			}
			
			var _lmtile = new LMTile(c_tile_id);
			
			_lmtile.set_tileset(_tileset);
			_lmtile.can_change = c_tile_id >= _tile_changes_starts_from;
			_tiles_list[t, p] = _lmtile;
		}
	}
	
	return _tiles_list;
}