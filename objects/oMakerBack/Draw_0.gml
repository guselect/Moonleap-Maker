

/// @description Insert description here
// You can write your code in this editor
if instance_exists(oPlayer)
{
	if oPlayer.night=true
	{draw_sprite_tiled(sBackNight,oLevelMaker.selected_style,0,0)}
	else
	{draw_sprite_tiled(sBackDay,oLevelMaker.selected_style,0,0)}
}
else
{
	draw_sprite_tiled(sBackDay,oLevelMaker.selected_style,0,0)
}















