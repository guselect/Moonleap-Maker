if instance_exists(oPauseUI)
or instance_exists(oPortal)
or instance_exists(oLevelMaker) and oLevelMaker.camera_current_interpolation != 1 {
  exit;
}

var _fog_alpha = 1 - fade_in_time / fade_in_time_max;

draw_sprite_tiled_ext(sprite_index,image_index,round(x),y-8, 1, 1, c_white, _fog_alpha);

//draw_set_alpha(_fog_alpha);
pal_swap_set(sTestpal, 1, false);

draw_surface_ext(application_surface, -53, -53, 1, 1, 0, c_white, _fog_alpha);

pal_swap_reset();
//draw_set_alpha(1);

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