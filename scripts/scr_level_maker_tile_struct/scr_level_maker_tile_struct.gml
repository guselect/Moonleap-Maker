function LMTile(_tile_id) constructor {
	tile_id = _tile_id;
	original_tile_id = _tile_id;
	tileset = undefined;
	
	colorblind_icon_frame = -1;
	
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
	
	set_colorblind_icon_frame = function(_frame) {
		colorblind_icon_frame = _frame;
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
	}
	
	draw_sprite_cursor = function(_x, _y) {
		draw_tile(tileset, tile_id, 0, _x, _y);
	}
}

function level_maker_get_tiles_list(_style) {
	var _tileset = undefined;
	var _tiles_amount = 0; // the amount of tiles the matching tileset has
	var _tile_changes_starts_from = 0; // the tile start index where the sprites starts to change
	var _animated_tiles = {}; // the tiles that have animation. It is used sprite instead of tile.
  var _excluded_tile_indexes = []; // the tiles to be ignored on level maker
  var _tiles_list = []; // the result of the tiles list
	var _pages = 1; // number of tile pages to show in the level editor
	
	switch(_style) {
		case LEVEL_MAKER_STYLE.GRASS:
			_tileset = tMakerGrassDay;
			_pages = 4;
			_tiles_amount = 56;
			_tile_changes_starts_from = 38;
      _excluded_tile_indexes = [14, 37];
			break;

		case LEVEL_MAKER_STYLE.CLOUDS:
			_tileset = tMakerCloudDay;
			_pages = 4;
			_tiles_amount = 62;
			_tile_changes_starts_from = 37;
      _excluded_tile_indexes = [36, 44];
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

		case LEVEL_MAKER_STYLE.FLOWERS:
			_tileset = tMakerFlowerDay;
			_pages = 3;
			_tiles_amount = 38;
      _excluded_tile_indexes = [13, 22];
			_tile_changes_starts_from = infinity; // infinity = no tiles that changes day/night in this tileset
			break;

		case LEVEL_MAKER_STYLE.SPACE:
			_tileset = tMakerSpaceDay;
			_pages = 3;
			_tiles_amount = 53;
			_tile_changes_starts_from = 34;
      _excluded_tile_indexes = [33, 35, 39, 40, 41, 42, 43];
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

		case LEVEL_MAKER_STYLE.DUNGEON:
			_tileset = tMakerDungeonDay;
			_pages = 4;
			_tiles_amount = 57;
			_tile_changes_starts_from = 45;
      _excluded_tile_indexes = [38];
      _animated_tiles = {
        "_56": {
          sprite_day: sAnimTileDunTochaDay,
          sprite_night: sAnimTileDunTochaNight,
        },
      }
			break;
	}
	
  var _c_tile_id = 0;

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

      while array_contains(_excluded_tile_indexes, _c_tile_id) {
        _c_tile_id++;
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
			_lmtile.set_colorblind_icon_frame(_c_tile_id >= _tile_changes_starts_from ? 0 : -1);
			
			_tiles_list[t, p] = _lmtile;
		}
	}
	
	return _tiles_list;
}
