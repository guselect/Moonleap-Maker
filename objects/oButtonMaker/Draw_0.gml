if (image_index == LEVEL_MAKER_BUTTON_TYPE.TEST_LEVEL)
{
	var _scale = image_xscale;
	draw_sprite_ext(sButtonStretch, 0, x + drawx, y + drawy + drawplus, _scale, _scale, 0, c_white, 1);
	
	var _frame = level_maker_is_editing() ? 1 : 2;
	draw_sprite(sButtonStretch, _frame, x + drawx - 16 + _scale * 16, y + drawy - 16 + _scale * 16 + drawplus);
}
else if (image_index == LEVEL_MAKER_BUTTON_TYPE.CHANGE_LAYER)
{
	switch (oLevelMaker.current_layer)
	{
		case LEVEL_MAKER_LAYERS.FOREGROUND:
			draw_sprite(sprite_index, image_index, x + drawx, y + drawy + drawplus);
			break;
		case LEVEL_MAKER_LAYERS.OBJECTS:
			draw_sprite(sprite_index, image_index + 1, x + drawx, y + drawy + drawplus);
			break;
		case LEVEL_MAKER_LAYERS.BACKGROUND_1:
			draw_sprite(sprite_index, image_index + 2, x + drawx, y + drawy + drawplus);
			break;
		case LEVEL_MAKER_LAYERS.BACKGROUND_2:
			draw_sprite(sprite_index, image_index + 3, x + drawx, y + drawy + drawplus);
			break;
		default:
			draw_sprite(sprite_index, image_index, x + drawx, y + drawy + drawplus);
			break;
	}
}
else
{
	draw_sprite(sprite_index, image_index, x + drawx, y + drawy + drawplus);
}
