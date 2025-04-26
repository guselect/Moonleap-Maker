/// @description Insert description here
// You can write your code in this editor


if time > 0 {
    gpu_set_fog(true, make_color_rgb(170,255,255), 0, 1);
}

//draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,c_white,1)
if trueblack {
    pal_swap_set(sPlayerPal, night + 2, 0)
} else {
    pal_swap_set(sPlayerPal, night, 0)
} 
if neutral {
    pal_swap_set(sPlayerPal,5,0)
}

draw_self();

gpu_set_fog(false, make_color_rgb(170,255,255),0,1)

pal_swap_reset()