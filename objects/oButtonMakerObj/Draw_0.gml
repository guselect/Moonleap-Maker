// Draw button
var button_sprite = oLevelMaker.current_layer == LEVEL_MAKER_LAYERS.OBJECTS ? sButtonsMakerObj : sButtonsMakerTile;

draw_sprite(button_sprite, 0, xstart, ystart + drawplus);

// Draw object/tile
switch (oLevelMaker.current_layer) {
	case LEVEL_MAKER_LAYERS.OBJECTS:
		if not is_undefined(object)
    and not is_undefined(object.button_sprite_sprite_index) {
      object.draw_button_sprite(xx, yy + drawplus);
    } else if sprite_exists(sprite_index) {
      var _object = object.index,
          _sprite = sprite_index,
          _frame = 0;

      draw_sprite_ext(_sprite, _frame, xx, yy + drawplus, scale, scale, image_angle, image_blend, 1);
    }
		
    var _object_colorblind_icon_frame = object.colorblind_icon_frame;
		if global.settings.filter and _object_colorblind_icon_frame >= 0 {
      draw_sprite(sColorBlind, _object_colorblind_icon_frame, xstart, ystart + drawplus);
    }
  break;
	
  default:
		if not is_undefined(tile) and tile != 0 {
      tile.draw_sprite_preview(x - 8, y - 8 + drawplus);
    }
		
    var _tile_colorblind_icon_frame = tile.colorblind_icon_frame;
		if global.settings.filter and _tile_colorblind_icon_frame >= 0 {
      draw_sprite(sColorBlind, _tile_colorblind_icon_frame, x, y + drawplus);
    }
  break;
}