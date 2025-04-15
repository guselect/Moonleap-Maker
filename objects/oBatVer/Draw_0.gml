/// @description Insert description here
// You can write your code in this editor

pal_swap_set(sSnailPal,palette_index,0)


if wing=2
{
	draw_self_perfect()
}

if wing=0
{
	var xx=x-17 var yy=y-12
	draw_sprite_part_ext(sprite_index,image_index+1,9,0,sprite_width-18,sprite_height,xx+9,yy,image_xscale,image_yscale,c_white,1)
}

if wing=1
{
	var xx=x-17 var yy=y-12
	draw_sprite_part_ext(sprite_index,image_index+0,0,0,sprite_width-9,sprite_height,xx,yy,image_xscale,image_yscale,c_white,1)
}

if wing=-1
{
	var xx=x-17 var yy=y-12
	draw_sprite_part_ext(sprite_index,image_index+2,9,0,sprite_width,sprite_height,xx+9,yy,image_xscale,image_yscale,c_white,1)
}

pal_swap_reset()