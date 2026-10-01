pal_swap_set(sSnailPal,palette_index,0)
draw_sprite_wrap_ext_room(sindex, iindex, x, y, xindex, image_yscale, 0, c_white, 1);
pal_swap_reset()

if global.settings.filter {
  draw_sprite_ext(sColorBlind16, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);
}
