/// @description Insert description here
// You can write your code in this editor

pal_swap_set(sSnailPal,palette_index,0)

var _xx = 0, _yy = 0;
if wing == 2 {
	draw_self_perfect()
}

if wing == 0 {
	_xx = x - 17;
	_yy = y - 12;
	draw_sprite_part_ext(sprite_index,image_index+1,9,0,sprite_width-18,sprite_height,xx+9,yy,image_xscale,image_yscale,c_white,1)
}

if wing == 1 {
	_xx = x - 17;
	_yy = y - 12;
	draw_sprite_part_ext(sprite_index,image_index+0,0,0,sprite_width-9,sprite_height,xx,yy,image_xscale,image_yscale,c_white,1)
}

if wing == -1 {
	_xx = x - 17;
	_yy = y - 12;
	draw_sprite_part_ext(sprite_index,image_index+2,9,0,sprite_width,sprite_height,xx+9,yy,image_xscale,image_yscale,c_white,1)
}

pal_swap_reset()

//var _bbox_width = bbox_right - bbox_left;
//var _bbox_height = bbox_bottom - bbox_top;
//var _xx_diff = (xx - x);
//var _yy_diff = (yy - y);

//draw_set_color(c_yellow);
//draw_rectangle(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, true);
//draw_set_color(c_lime);
//draw_rectangle(bbox_left + _xx_diff, bbox_top + _yy_diff, bbox_right - 1 + _xx_diff, bbox_bottom - 1 + _yy_diff, true);
//draw_set_color(-1);