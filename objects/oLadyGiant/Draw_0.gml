/// @description Insert description here
// You can write your code in this editor
pal_swap_set(sSnailPal,palette_index,0)

if round(hsp) != 0 then drawhsp = hsp;

if sprite_index == sturn_day or sprite_index == sturn_dayB
{
	if drawhsp<0
	{
	draw_sprite_ext(sprite_index,image_index,x-16,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index,x+16,y,image_xscale,image_yscale,0,c_white,1)
	}
	if drawhsp>0
	{
	draw_sprite_ext(sprite_index,image_index,x+16,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index,x-16,y,image_xscale,image_yscale,0,c_white,1)
	}	
}
else
{
	if drawhsp<0
	{
	draw_sprite_ext(sprite_index,image_index,x-16,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index+1,x,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index+2,x+16,y,image_xscale,image_yscale,0,c_white,1)
	}
	if drawhsp>0
	{
	draw_sprite_ext(sprite_index,image_index,x+16,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index+1,x,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index+2,x-16,y,image_xscale,image_yscale,0,c_white,1)
	}
}

pal_swap_reset()

if global.settings.filter {
  draw_sprite_ext(sColorBlind16,startindex,x,y,image_xscale,image_yscale,0,c_white,1)
}
