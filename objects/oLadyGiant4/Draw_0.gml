pal_swap_set(sSnailPal, palette_index, 0);

if round(hsp)!=0 {
	drawhsp = hsp
}

if sprite_index=sturn_day or sprite_index=sturn_dayB
{
	if palette_index=2 {
		sprindex=sLadyTurnSun
	}
	
	if drawhsp<0
	{
		draw_sprite_ext(sprite_index,image_index,x-24,y,image_xscale,image_yscale,0,c_white,1)
		draw_sprite_ext(sprite_index,image_index,x-8,y,image_xscale,image_yscale,0,c_white,1)
		draw_sprite_ext(sprite_index,image_index,x+8,y,image_xscale,image_yscale,0,c_white,1)
		draw_sprite_ext(sprite_index,image_index,x+24,y,image_xscale,image_yscale,0,c_white,1)
	}
	if drawhsp>0
	{

		draw_sprite_ext(sprite_index,image_index,x+24,y,image_xscale,image_yscale,0,c_white,1)
		draw_sprite_ext(sprite_index,image_index,x+8,y,image_xscale,image_yscale,0,c_white,1)
		draw_sprite_ext(sprite_index,image_index,x-8,y,image_xscale,image_yscale,0,c_white,1)
		draw_sprite_ext(sprite_index,image_index,x-24,y,image_xscale,image_yscale,0,c_white,1)
	}	
}
else
{
	if palette_index=2{sprindex=sLadySun} else {sprindex=sprite_index} 
	if drawhsp<0
	{
	draw_sprite_ext(sprite_index,image_index,x-24,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index+1,x-8,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index+2,x+8,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index+3,x+24,y,image_xscale,image_yscale,0,c_white,1)
	}
	if drawhsp>0
	{
	draw_sprite_ext(sprite_index,image_index,x+24,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index+1,x+8,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index+2,x-8,y,image_xscale,image_yscale,0,c_white,1)
	draw_sprite_ext(sprite_index,image_index+3,x-24,y,image_xscale,image_yscale,0,c_white,1)
	}
}


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

if !palette_index=2 {pal_swap_reset()}