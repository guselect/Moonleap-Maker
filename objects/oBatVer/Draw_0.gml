pal_swap_set(sSnailPal, palette_index, 0);

var _xx = 0, _yy = 0;

switch(wing) {
	case -1:
		_xx = x - 17;
		_yy = y - 12;
		draw_sprite_part_ext(sprite_index, image_index + 2, 9, 0, sprite_width, sprite_height, _xx + 9, _yy, image_xscale, image_yscale, c_white, 1);
		break;
		
	case 0:
		_xx = x - 17;
		_yy = y - 12;
		draw_sprite_part_ext(sprite_index, image_index + 1, 9, 0, sprite_width - 18, sprite_height, _xx + 9, _yy, image_xscale, image_yscale, c_white, 1);
		break;
		
	case 1:
		_xx = x - 17;
		_yy = y - 12;
		draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_width - 9, sprite_height, _xx, _yy, image_xscale, image_yscale, c_white, 1);
		break;
		
	default:
		draw_self_perfect();
		break;
}

pal_swap_reset();
