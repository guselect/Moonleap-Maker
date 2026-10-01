var xx = x + random_range(-shake, shake);
var yy = y;

if trueblack {
    pal_swap_set(sPlayerPal,night+2,0)
} else if oCamera.current_skin != 5 {
    pal_swap_set(sPlayerPal,night,0)
} 

if mode == PLAYER_MODE.NEUTRAL {
    pal_swap_set(sPlayerPal,5,0)
}

if white != 0 {
	if white < 2 then pal_swap_set(sPlayerPal,4,0);
	if white < 1 then pal_swap_set(sPlayerPal,7,0);
	if white >= 2 then pal_swap_set(sPlayerPal,8,0);
}



if flash > 0 or godmode then pal_swap_set(sPlayerPal,4,0);

draw_sprite_wrap_ext_room(sprite_index, image_index, xx, yy, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if sprite_index == PlayerClimb and cape {
	//capeoutline
  with(oCape) {
    draw_sprite(sTinySmoke160, 8, x, y + 1);
  }
  with(oCape) {
    draw_sprite(sprite_index, image_index, x, y + 1);
  } 
}

pal_swap_reset()