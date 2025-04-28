if instance_exists(oPauseMenu) or instance_exists(oPortal) {exit;}

draw_sprite_tiled(sprite_index,image_index,round(x),y-8)

pal_swap_set(sTestpal,1,false)

draw_surface(application_surface,0,0);
pal_swap_reset()

if instance_exists(oParentDay)
{
	with (oParentDay)
	{
		if global.settings.filter=true
		{draw_sprite_ext(sColorBlind,0,x,y,image_xscale,image_yscale,0,c_white,1)}
	}
}
if instance_exists(oParentNight)
{
	with (oParentNight)
	{
		if global.settings.filter=true
		{draw_sprite_ext(sColorBlind,1,x,y,image_xscale,image_yscale,0,c_white,1)}
	}
}