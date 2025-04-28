if(image_index == 6){
	var _scale = image_xscale;
	draw_sprite_ext(sButtonStretch,0,x+drawx,y+drawy+drawplus,_scale,_scale,0,c_white,1);
	draw_sprite(sButtonStretch, (level_maker_is_editing() ? 1 : 2),x+drawx-16+_scale*16,y+drawy-16+_scale*16+drawplus);
	
} else {
	draw_sprite(sprite_index,image_index,x+drawx,y+drawy+drawplus)

}