xx=round(x)
yy=drawy

pal_swap_set(sSnailPal, palette_index, 0);
draw_sprite_wrap_ext_room(sprite_index, image_index, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
pal_swap_reset();

if startindex == 0 {
	if global.settings.filter {
    draw_sprite_wrap_ext_room(sColorBlind16, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);
  }
}

if startindex == 1 {
	if global.settings.filter {
    draw_sprite_wrap_ext_room(sColorBlind16, 1, x, y, image_xscale, image_yscale, 0, c_white, 1);
  }
}
