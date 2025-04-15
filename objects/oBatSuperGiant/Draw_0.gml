/// @description Insert description here
// You can write your code in this editor
pal_swap_set(sSnailPal,palette_index,0)

if round(hsp)!=0 { drawhsp=hsp}

var xx = x - 25;
var yy = y - 12;

	if drawhsp<=0
	{
	draw_sprite_part_ext(sprite_index,image_index+0,0,0,sprite_width-9,sprite_height,xx-16,yy,image_xscale,image_yscale,c_white,1)
	draw_sprite_part_ext(sprite_index,image_index+1,9,0,sprite_width-18,sprite_height,xx+9,yy,image_xscale,image_yscale,c_white,1)
	draw_sprite_part_ext(sprite_index,image_index+2,9,0,sprite_width-18,sprite_height,xx+9+16,yy,image_xscale,image_yscale,c_white,1)
	draw_sprite_part_ext(sprite_index,image_index+3,9,0,sprite_width,sprite_height,xx+16+16+9,yy,image_xscale,image_yscale,c_white,1)
	}
	if drawhsp>0
	{
	draw_sprite_part_ext(sprite_index,image_index+3,9,0,sprite_width,sprite_height,xx+16+16+9,yy,image_xscale,image_yscale,c_white,1)
	draw_sprite_part_ext(sprite_index,image_index+2,9,0,sprite_width-18,sprite_height,xx+9+16,yy,image_xscale,image_yscale,c_white,1)
	draw_sprite_part_ext(sprite_index,image_index+1,9,0,sprite_width-18,sprite_height,xx+9,yy,image_xscale,image_yscale,c_white,1)
	draw_sprite_part_ext(sprite_index,image_index+0,0,0,sprite_width-9,sprite_height,xx-16,yy,image_xscale,image_yscale,c_white,1)
	}


pal_swap_reset()
