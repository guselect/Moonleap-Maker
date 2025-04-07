pal_swap_set(sSnailPal,palette_index,0)

xx=round(x)
yy=drawy
var roomw=room_width
var roomh=room_height

draw_self_perfect()
draw_sprite_ext(sprite_index,image_index,xx-roomw,yy,image_xscale,image_yscale,0,c_white,1)
draw_sprite_ext(sprite_index,image_index,xx+roomw,yy,image_xscale,image_yscale,0,c_white,1)

draw_sprite_ext(sprite_index,image_index,xx,yy-roomh,image_xscale,image_yscale,0,c_white,1)
draw_sprite_ext(sprite_index,image_index,xx,yy+roomh,image_xscale,image_yscale,0,c_white,1)



pal_swap_reset()

if startindex=0
{
	if global.settings.filter=true
	{draw_sprite_ext(sColorBlind16,0,x,y,image_xscale,image_yscale,0,c_white,1)}
}

if startindex=1
{
	if global.settings.filter=true
	{draw_sprite_ext(sColorBlind16,1,x,y,image_xscale,image_yscale,0,c_white,1)}
}