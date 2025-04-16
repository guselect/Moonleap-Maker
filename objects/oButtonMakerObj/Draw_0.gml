// Draw button
var button_sprite = oLevelMaker.current_layer == LEVEL_CURRENT_LAYER.OBJECTS ? sButtonsMakerObj : sButtonsMakerTile;
draw_sprite(button_sprite, 0, xstart, ystart + drawplus);

// Draw object/tile
switch (oLevelMaker.current_layer) {
	case LEVEL_CURRENT_LAYER.OBJECTS:
		if not is_undefined(object.sprite_button_sprite_index) then
			object.draw_sprite_button_part(x, y + drawplus);	
		else if sprite_exists(sprite_index) then
			draw_sprite_ext(sprite_index, 0, x, y + drawplus, scale, scale, image_angle, image_blend, 1);
		break;
	default:
		if not is_undefined(tile) and tile != 0
			tile.draw_sprite_preview(x, y + drawplus);
		break;
}