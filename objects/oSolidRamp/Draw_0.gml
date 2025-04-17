var _x = x;
var _y = y;

if sindex == sBlockRampMaskDark {
	_x = x - 16;
	_y = y - 8;
	
	if sign(image_xscale) == -1 {
		_x = x + 16;
	}
}

draw_sprite_ext(sindex, image_index, _x, _y, image_xscale, image_yscale, image_angle, c_white, 1);
