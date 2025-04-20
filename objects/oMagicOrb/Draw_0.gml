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
var roomw = room_width;
var roomh = room_height;

draw_self_perfect()
draw_sprite_ext(sprite_index,image_index,xx-roomw,yy,image_xscale,image_yscale,0,c_white,1)
draw_sprite_ext(sprite_index,image_index,xx+roomw,yy,image_xscale,image_yscale,0,c_white,1)

draw_sprite_ext(sprite_index,image_index,xx,yy-roomh,image_xscale,image_yscale,0,c_white,1)
draw_sprite_ext(sprite_index,image_index,xx,yy+roomh,image_xscale,image_yscale,0,c_white,1)


if scare {
    draw_sprite(sGemScare,image_index,xx,yy)
}

pal_swap_reset()