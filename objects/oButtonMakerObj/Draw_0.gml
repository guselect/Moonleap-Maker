// Draw button
var button_sprite = oLevelMaker.current_layer == LEVEL_CURRENT_LAYER.OBJECTS ? sButtonsMakerObj : sButtonsMakerTile;

draw_sprite(button_sprite, 0, xstart, ystart + drawplus);

// Draw object/tile
switch (oLevelMaker.current_layer) {
	case LEVEL_CURRENT_LAYER.OBJECTS:
		//var _sprite = object_get_sprite(object.index)
		//var _sprite_xoffset = sprite_get_xoffset(_sprite);
		//var _sprite_yoffset = sprite_get_yoffset(_sprite);
		//var _sprite_width = sprite_get_width(_sprite);
		//var _sprite_height = sprite_get_height(_sprite);
		
		//var _sprite_x = x - _sprite_xoffset + _sprite_width / 2;
		//var _sprite_y = y - _sprite_yoffset + _sprite_height / 2;
	
		if not is_undefined(object.sprite_button_sprite_index) then
			object.draw_sprite_button_part(xx, yy + drawplus);
		//else
			//draw_sprite_ext(_sprite, 0, x - _sprite_x, y - _sprite_y + drawplus, scale, scale, image_angle, image_blend, 1);
		else if sprite_exists(sprite_index) then
			draw_sprite_ext(sprite_index, 0, xx, yy + drawplus, scale, scale, image_angle, image_blend, 1);
		
		if global.settings.filter and object.can_change then
			draw_sprite(sColorBlind, object.is_moon_variant, xstart, ystart + drawplus);
		break;
	default:
		if not is_undefined(tile) and tile != 0
			tile.draw_sprite_preview(x - 8, y - 8 + drawplus);
		
		if global.settings.filter and tile.can_change then
			draw_sprite(sColorBlind, 0, x, y + drawplus);
		break;
}

//draw_set_color(c_yellow);
//draw_rectangle(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, true);
//draw_set_color(-1);