/// @description Insert description here
// You can write your code in this editor
pal_swap_set(sSnailPal,palette_index,0)
draw_self_perfect()
pal_swap_reset()

if oCamera.filter=true
draw_sprite_ext(sColorBlind16,0,x,y,image_xscale,image_yscale,0,c_white,1)
