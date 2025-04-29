enum LEVEL_CURRENT_LAYER { FOREGROUND, OBJECTS, BACKGROUND_1, BACKGROUND_2}
enum LEVEL_CURSOR_TYPE { NOTHING, CURSOR, FINGER, ERASER, CANCEL }
enum LEVEL_STYLE { GRASS, CLOUDS, FLOWERS, SPACE, DUNGEON,LENGTH }
enum LEVEL_EDITOR_MODE { EDITING, TESTING }
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
	
	can_change = false;
	is_moon_variant = false;
	
	preview_image_index_horizontal = undefined;
	preview_image_index_vertical = undefined;
	
	sprite_button_sprite_index = undefined;
	sprite_button_image_index = 0;
	sprite_button_x_offset = 0;
	sprite_button_y_offset = 0;
	sprite_button_part_left = 0;
	sprite_button_part_top = 0;
	sprite_button_part_width = 16;
	sprite_button_part_height = 16;

	set_can_change = function(_can_change) {
		can_change = _can_change;
		return self;
	}
	
	set_is_moon_variant = function(_is_moon_variant) {
		is_moon_variant = _is_moon_variant;
		return self;
	}
	
	set_preview_index_horizontal = function(_image_index_flipped = 0) {
		preview_image_index_horizontal = _image_index_flipped;
		return self;
	}
	
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
		return array_find_index_of_value(tags, _tag) == -1 ? false : true;
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
	original_tile_id = _tile_id;
	tileset = undefined;
	
	can_change = false;
	is_animated = false;
	
	sprite_day = -1;
	sprite_night = -1;

    xscale = 1;
    yscale = 1;
	
	set_original_tile_id = function(_original_tile_id) {
		original_tile_id = _original_tile_id;
	}
	
	set_tileset = function(_tileset) {
		tileset = _tileset;
	}
	
	set_is_animated = function(_is_animated) {
		is_animated = _is_animated;
	}
	
	set_can_change = function(_can_change) {
		can_change = _can_change;
	}
	
	set_animated_sprites = function(_sprite_day, _sprite_night) {
		sprite_day = _sprite_day;
		sprite_night = _sprite_night;
	}
	
	set_tile_frames = function(_tile_frames_id) {
		tile_frames_id = _tile_frames_id;
	}
	
	draw_sprite_preview = function(_x, _y) {
		draw_tile(tileset, original_tile_id, 0, _x, _y);
		
		//if can_change and _show_indicator then
		//	draw_sprite(sMakerChangeIcon, 0, _x + 16, _y + 16);
	}
	
	draw_sprite_cursor = function(_x, _y) {
		draw_tile(tileset, tile_id, 0, _x, _y);
	}
}

function level_maker_get_tileset_layers() {
	return [
		layer_get_id("Tiles_Foreground"),
		layer_get_id("Tiles_Background1"),
		layer_get_id("Tiles_Background2"),
		layer_get_id("Tiles_Background3"),
		layer_get_id("Tiles_Background4")
	];
}

function level_maker_get_asset_layers() {
	return [
		layer_get_id("Assets_Foreground"),
		layer_get_id("Assets_Background1"),
		layer_get_id("Assets_Background2"),
		layer_get_id("Assets_Background3"),
		layer_get_id("Assets_Background4")
	];
}


function level_maker_get_instances_layers() {
	return [
		layer_get_id("Instances_Foreground"),
		layer_get_id("Instances_Background1"),
		layer_get_id("Instances_Background2"),
		layer_get_id("Instances_Background3"),
		layer_get_id("Instances_Background4")
	];
}

function level_maker_get_objects_list() {
	var _obj = [];
	
	_obj[0, 00] =	new LMObject(oPlayer,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_unique", "is_player");
	_obj[0, 01] =	new LMObject(oSolid,				16, 16).add_tag("grid_16", "is_holdable");
	_obj[0, 02] =	new LMObject(oBrokenStone,		16, 16).add_tag("grid_16", "is_holdable");
	_obj[0, 03] =	new LMObject(oPlatGhost,		16, 16).add_tag("can_spin");
	_obj[0, 04] =	new LMObject(oSolidRamp,		32, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBlockRampEditor, 0, 16, 0, -8, -8);
	_obj[0, 05] =	new LMObject(oPermaSpike,		16, 16).add_tag("is_holdable");
	_obj[0, 06] =	new LMObject(oSolidDay,			16, 16, SPRITE_ORIGIN.OFFSET5).add_tag("grid_16", "is_holdable").set_can_change(true);
	_obj[0, 07] =	new LMObject(oSolidNight,		16, 16, SPRITE_ORIGIN.OFFSET5).add_tag("grid_16", "is_holdable").set_can_change(true).set_is_moon_variant(true);
	_obj[0, 08] =	new LMObject(oLadderDay,		16, 16).set_can_change(true);
	_obj[0, 09] =	new LMObject(oLadderNight,		16, 16).set_can_change(true).set_is_moon_variant(true);
	_obj[0, 10] =	new LMObject(oStar,				16, 16).add_tag("can_spin");
	_obj[0, 11] =	new LMObject(oStarRunning,		16, 16);
	_obj[0, 12] =	new LMObject(oSnail,				16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip").set_sprite_button_part(sSnailWalk, 0, 0, 2, -9, 0).set_can_change(true);
	_obj[0, 13] =	new LMObject(oSnailNight,		16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip").set_sprite_button_part(sSnailIdleNight, 0, 0, 2, -11, 0, 18).set_can_change(true).set_is_moon_variant(true);
	_obj[0, 14] =	new LMObject(oLady,				16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_preview_index_horizontal(1);
	_obj[0, 15] =	new LMObject(oBat,				16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip", "grid_16").set_sprite_button_part(sBat, 0, 10, 4, -7, -8);
	
	_obj[1, 00] =	new LMObject(oPlayerDir,		16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_unique", "is_player");
	_obj[1, 01] =	new LMObject(oBigSolid,			32, 32).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBlockGrayGiant, 0, 0, 0, 0, 0);
	_obj[1, 02] =	new LMObject(oBrokenStoneBig,	32, 32).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBrokenStoneBig, 0, 0, 0, 0, 0);
	_obj[1, 03] =	new LMObject(oLadderNeutral,	16, 16);
	_obj[1, 04] =	new LMObject(oStarColor,		16, 16);
	_obj[1, 05] =	new LMObject(oStarRunningColor,	16, 16);
	_obj[1, 06] =	new LMObject(oMush,				16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_spin");
	_obj[1, 07] =	new LMObject(oMushGray,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_spin").set_sprite_button_part(sMushGrayUI, 0, 0, 0, 0, 0);
	_obj[1, 08] =	new LMObject(oSnailGray,		16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip");
	_obj[1, 09] =	new LMObject(oLadyGray,			16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sLadyGrayUI, 0, 3, 0, -8, -8);
	_obj[1, 10] =	new LMObject(oLadyVer,			16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip", "is_vertical").set_preview_index_vertical(1).set_sprite_button_part(sLadyVerUI, 0, 3, 1, -8, -8);
	_obj[1, 11] =	new LMObject(oLadyGiant,		48, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_preview_index_horizontal(1).set_sprite_button_part(sLadyGiant, 0, 19, 1, -8, -8);
	_obj[1, 12] =	new LMObject(oLadyGiant4,		64, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_preview_index_horizontal(1).set_sprite_button_part(sLadyGiant4, 0, 14, 1, -8, -8);
	_obj[1, 13] =	new LMObject(oBatVer,			16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip", "grid_16", "is_vertical").set_preview_index_vertical(1).set_sprite_button_part(sBatDown, 0, 10, 4, -7, -8);
	_obj[1, 14] =	new LMObject(oBatGiant,			48, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBatGiant, 0, 21, 1, -8, -8)
	_obj[1, 15] =	new LMObject(oBatSuperGiant,	64, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBatGiant4, 0, 12, 1, -8, -8);
	
	_obj[2, 00] =	new LMObject(oPlayerNeutral,	16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_unique", "is_player");
	_obj[2, 01] =	new LMObject(oBird,				16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip", "is_unique");
	_obj[2, 02] =	new LMObject(oKey,				16, 16);
	_obj[2, 03] =	new LMObject(oKeyDoor,			16, 16);
	_obj[2, 04] =	new LMObject(oKeyTall,			16, 32).set_sprite_button_part(sKeyDoorTallUI, 0, 0, 8, -8, -8);
	_obj[2, 05] =	new LMObject(oKeyDoorTall,		16, 32).set_sprite_button_part(sKeyDoorTall, 0, 0, 8, -8, -8);
	_obj[2, 06] =	new LMObject(oKeyWide,			32, 16).set_sprite_button_part(sKeyDoorWideUI, 0, 8, 0, -8, -8);
	_obj[2, 07] =	new LMObject(oKeyDoorWide,		32, 16).set_sprite_button_part(sKeyDoorWide, 0, 8, 0, -8, -8);
	_obj[2, 08] =	new LMObject(oKeyTallWide,		32, 32).set_sprite_button_part(sKeyDoorTallWideUI, 0, 0, 0, -8, -8);
	_obj[2, 09] =	new LMObject(oKeyDoorTallWide,	32, 32).set_sprite_button_part(sKeyDoorWideTall, 0, 0, 0, -8, -8);
	_obj[2, 10] =	new LMObject(oMagicOrb,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_unique", "is_orb");
	_obj[2, 11] =	new LMObject(oStarFly,			16, 16);
	_obj[2, 12] =	new LMObject(oSolidInv,			16, 16).add_tag("grid_16", "is_holdable");
	_obj[2, 13] =	undefined; //new LMObject(oNope,             16, 16).add_tag("grid_16", "is_holdable");
	_obj[2, 14] =	undefined;
	_obj[2, 15] =	undefined;

	return _obj;
}

function level_maker_get_tiles_list(_style) {
	var _tiles_list = []; // result of the list
	var _tileset = undefined;
	var _tiles_amount = 0; // the amount of tiles the matching tileset has
	var _tile_changes_starts_from = 0;
	var _animated_tiles = {};
	var _pages = 1;
	var _c_tile_id = 0;
	
	switch(_style) {
		case LEVEL_STYLE.GRASS:
			_tileset = tMakerGrassDay;
			_pages = 4;
			_tiles_amount = 56;
			_tile_changes_starts_from = 38;
			break;
		case LEVEL_STYLE.CLOUDS:
			_tileset = tMakerCloudDay;
			_pages = 4;
			_tiles_amount = 62;
			_tile_changes_starts_from = 37;
			_animated_tiles = {
				"_38": {
					sprite_day: sAnimTileCloudCloudEdgeDay,
					sprite_night: sAnimTileCloudCloudEdgeNight,
				},
				"_39": {
					sprite_day: sAnimTileCloudCloudCenterDay,
					sprite_night: sAnimTileCloudCloudCenterNight,
				},
				"_59": {
					sprite_day: sAnimTileCloudStar1Day,
					sprite_night: sAnimTileCloudStar1Night,
				},
				"_60": {
					sprite_day: sAnimTileCloudStar2Day,
					sprite_night: sAnimTileCloudStar2Night,
				},
				"_61": {
					sprite_day: sAnimTileCloudStar3Day,
					sprite_night: sAnimTileCloudStar3Night,
				}
			};
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
            _animated_tiles = {
                "_37": {
                    sprite_day: sAnimTileSpaceCloudCenterDay,
					sprite_night: sAnimTileSpaceCloudCenterNight,
                },
                "_38": {
                    sprite_day: sAnimTileSpaceCloudEdgeDay,
					sprite_night: sAnimTileSpaceCloudEdgeNight,
                },
                "_50": {
                    sprite_day: sAnimTileSpaceStar1Day,
					sprite_night: sAnimTileSpaceStar1Night,
                },
                "_51": {
                    sprite_day: sAnimTileSpaceStar2Day,
					sprite_night: sAnimTileSpaceStar2Night,
                },
                "_52": {
                    sprite_day: sAnimTileSpaceStar3Day,
					sprite_night: sAnimTileSpaceStar3Night,
                },
            }
			break;
		case LEVEL_STYLE.DUNGEON:
			_tileset = tMakerDungeonDay;
			_pages = 4;
			_tiles_amount = 57;
			_tile_changes_starts_from = 45;
            _animated_tiles = {
                "_56": {
                    sprite_day: sAnimTileDunTochaDay,
					sprite_night: sAnimTileDunTochaNight,
                },
            }
			break;
	}
	
	for (var t = 0; t < _pages; t++) {
		for (var p = 0; p < 16; p++) {
			_c_tile_id++
			
			while _c_tile_id == 0 {
				_c_tile_id++;
			}
			
			if _c_tile_id >= _tiles_amount {
				_tiles_list[t, p] = undefined;
				continue;
			}
			
			var _lmtile = new LMTile(_c_tile_id);
			var _struct_tile_name = $"_{_c_tile_id}";
			var _animated_tile = struct_read(_animated_tiles, _struct_tile_name, -1);
			
			if _animated_tile != -1 {
				_lmtile.set_is_animated(true);
				_lmtile.set_animated_sprites(_animated_tile.sprite_day, _animated_tile.sprite_night)
			}

			_lmtile.set_original_tile_id(_c_tile_id);
			_lmtile.set_tileset(_tileset);
			_lmtile.set_can_change(_c_tile_id >= _tile_changes_starts_from);
			
			_tiles_list[t, p] = _lmtile;
		}
	}
	
	return _tiles_list;
}

function level_maker_get_layers_at() {

}

function level_maker_get_background_tile_layer_name() {
	switch(oLevelMaker.current_layer) {
		case LEVEL_CURRENT_LAYER.FOREGROUND:
			return "Tiles_Foreground";
		case LEVEL_CURRENT_LAYER.BACKGROUND_1:
			return "Tiles_Background1";
		case LEVEL_CURRENT_LAYER.BACKGROUND_2:
			return "Tiles_Background2";
		default:
			return -1;
	}
}

function level_maker_get_background_instances_layer_name() {
	switch(oLevelMaker.current_layer) {
		case LEVEL_CURRENT_LAYER.FOREGROUND:
			return "Instances_Foreground";
		case LEVEL_CURRENT_LAYER.BACKGROUND_1:
			return "Instances_Background1";
		case LEVEL_CURRENT_LAYER.BACKGROUND_2:
			return "Instances_Background2";
		default:
			return -1;
	}
}

function level_maker_get_layer_hover_text() {
	switch(oLevelMaker.current_layer) {
		case LEVEL_CURRENT_LAYER.FOREGROUND:
			return "1: Frente (Decoração)";
		case LEVEL_CURRENT_LAYER.OBJECTS:
			return "2: Objetos";
		case LEVEL_CURRENT_LAYER.BACKGROUND_1:
			return "3: Fundo (Decoração)";
		case LEVEL_CURRENT_LAYER.BACKGROUND_2:
			return "4: Fundo Distante (Decoração)";
		default:
			return "Camada desconhecida";
	}
}

function level_maker_is_editing() {
	return instance_exists(oLevelMaker) and oLevelMaker.mode == LEVEL_EDITOR_MODE.EDITING;
}

function is_level_maker_room() {
	return room == RoomMaker0;
}