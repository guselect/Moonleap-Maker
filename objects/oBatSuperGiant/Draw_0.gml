pal_swap_set(sSnailPal, palette_index, 0)

if round(hsp) != 0 then drawhsp = hsp;

var _xx = x - 25;
var _yy = y - 12;

if drawhsp <= 0 {
	draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_width - 9,sprite_height, _xx - 16, _yy, image_xscale, image_yscale, c_white, 1);
	draw_sprite_part_ext(sprite_index, image_index + 1, 9, 0, sprite_width - 18, sprite_height, _xx + 9, _yy, image_xscale, image_yscale, c_white, 1);
	draw_sprite_part_ext(sprite_index, image_index + 2, 9, 0, sprite_width - 18,sprite_height, _xx + 9 + 16, _yy, image_xscale, image_yscale, c_white, 1);
	draw_sprite_part_ext(sprite_index, image_index + 3, 9, 0, sprite_width, sprite_height, _xx + 32 + 9, _yy, image_xscale, image_yscale, c_white, 1);
}												  				  	 	 	 	 				  
												  				  	 	 	 	 				  
if drawhsp > 0 {							  				  	 	 	 	 				  
	draw_sprite_part_ext(sprite_index, image_index + 3, 9, 0, sprite_width, sprite_height, _xx + 32 + 9, _yy, image_xscale, image_yscale, c_white, 1);
	draw_sprite_part_ext(sprite_index, image_index + 2, 9, 0, sprite_width - 18, sprite_height, _xx + 9 + 16, _yy, image_xscale, image_yscale, c_white, 1);
	draw_sprite_part_ext(sprite_index, image_index + 1, 9, 0, sprite_width - 18, sprite_height, _xx + 9, _yy, image_xscale, image_yscale, c_white, 1);
	draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_width - 9, sprite_height, _xx - 16, _yy, image_xscale, image_yscale, c_white, 1);
}

pal_swap_reset();