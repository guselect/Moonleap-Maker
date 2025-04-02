draw_sprite(sButtonsMakerObj, 0, xstart, ystart + drawplus);

if not is_undefined(object.sprite_button) then
	object.draw_sprite_button_part(x, y + drawplus);	
else if sprite_exists(sprite_index) then
	draw_sprite_ext(sprite_index, 0, x, y + drawplus, scale, scale, image_angle, image_blend, 1);