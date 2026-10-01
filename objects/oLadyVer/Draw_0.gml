pal_swap_set(sSnailPal,palette_index,0)
draw_self_wrap_room();
pal_swap_reset();

if global.settings.filter {
  if startindex == 0 {
    draw_sprite_wrap_ext_room(sColorBlind16, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);
  } else if startindex == 1 {
    draw_sprite_wrap_ext_room(sColorBlind16, 1, x, y, image_xscale, image_yscale, 0, c_white, 1);
  }
}