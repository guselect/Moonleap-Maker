// Draw every tile in the level maker
if level_maker_is_editing() and not instance_exists(oPauseUI) {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x, _y],
          _xx = _x * LEVEL_MAKER_GRID_OBJECTS_TILE_SIZE,
			    _yy = _y * LEVEL_MAKER_GRID_OBJECTS_TILE_SIZE;
			
			if _object_grid == -1 {
        continue;
      }
			
			var _obj_index = _object_grid.object,
          _obj_x = _object_grid.top_left_x, 
          _obj_y = _object_grid.top_left_y,
          _xscale = _object_grid.xscale,
          _yscale = _object_grid.yscale,
          _angle = _object_grid.angle;
		
			if is_struct(_object_grid) and _obj_x == _x and _obj_y == _y {
        _obj_index.draw_preview_sprite(_xx, _yy, _xscale, _yscale, _angle);
			}
		}	
	}
}

draw_set_color(c_white);
draw_set_font(fntSmall);

// Background
draw_sprite(sPauseMaker, 0, 0, 0);

// Draw item preview on cursor
if current_layer == LEVEL_MAKER_LAYERS.OBJECTS {
	if cursor != LEVEL_MAKER_CURSOR.ERASER
	and is_cursor_inside_level 
	and level_maker_is_editing()
	and not instance_exists(oPauseUI)
	and not is_undefined(cursor_object_hovering)
	and not has_object_below_cursor {
		var _x = x + item_preview_offset_x,
		    _y = y + item_preview_offset_y,
		    _xscale = image_xscale,
		    _yscale = image_yscale,
        _angle = image_angle,
        _blend = c_white,
        _alpha = 0.6;
    
    cursor_object_hovering.draw_cursor_preview_sprite(_x, _y, _xscale, _yscale, _angle, _blend, _alpha);
	}
} else {
	if cursor != LEVEL_MAKER_CURSOR.ERASER
	and is_cursor_inside_level 
  and not is_undefined(selected_tile)
	and level_maker_is_editing() 
	and not instance_exists(oPauseUI) {
		var _x = floor(x / tileset_size) * tileset_size;
		var _y = floor(y / tileset_size) * tileset_size;

		draw_set_alpha(0.6);
		selected_tile.draw_sprite_cursor(_x, _y);
		draw_set_alpha(1);
	}
}
