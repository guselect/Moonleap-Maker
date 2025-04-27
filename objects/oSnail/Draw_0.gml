/// @description Insert description here
// You can write your code in this editor
pal_swap_set(sSnailPal,palette_index,0)
draw_sprite_ext(sindex,iindex,x,y,xindex,image_yscale,0,c_white,1)
pal_swap_reset()

if global.settings.filter=true
draw_sprite_ext(sColorBlind16,1,x,y,image_xscale,image_yscale,0,c_white,1)