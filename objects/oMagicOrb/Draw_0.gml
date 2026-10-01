if trueblack {
  pal_swap_set(sPlayerPal, night + 2, 0);
} else {
  pal_swap_set(sPlayerPal, night, 0);
}

if flash > 0 {
  pal_swap_set(sPlayerPal, 4, 0);
}

var xx = round(x);
var yy = round(y);

draw_sprite_wrap_ext_room(sprite_index, image_index, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if scare {
  draw_sprite(sGemScare, image_index, xx, yy);
}

pal_swap_reset()