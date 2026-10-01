if instance_exists(oPlayer)
{
	pal_swap_set(sPlayerPal, 5, 0);
}

draw_sprite_wrap_ext_room(sprite_index,image_index,round(x),round(y),image_xscale,image_yscale,image_angle,image_blend,image_alpha);

pal_swap_reset()
