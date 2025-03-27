draw_sprite(sButtonsMakerObj, 0, xstart, ystart + drawplus);
if sprite_exists(sprite_index) {
	var _sprite = is_undefined(obj.sprite_button) ? sprite_index : obj.sprite_button;
	
	draw_sprite_ext(sprite_index, 0, x, y + drawplus, scale, scale, image_angle, image_blend, 1);
	
	//var _nineslice = sprite_get_nineslice(sprite_index)
	
	//if _nineslice.enabled {
	//	draw_sprite_ext(sprite_index, 0, x, y + drawplus, scale, scale, image_angle, image_blend, 1);
	//} else {
	//	var _btn_x = obj.sprite_button_x;
	//	var _btn_y = obj.sprite_button_y;
	//	var _btn_width = obj.sprite_button_width;
	//	var _btn_height = obj.sprite_button_height;
		
	//	draw_sprite_part(sprite_index, 0, _btn_x, _btn_y, _btn_width, _btn_height, x, y + drawplus);
	//}
}