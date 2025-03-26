draw_set_color(color.nice_white)

if !instance_exists(oPause)
{
	draw_sprite_ext(sPauseMaker,0,0,0,1,1,0,c_white,0.5)
}
//if mouse_x>0 and mouse_x<320
{
	
}
draw_set_halign(fa_center)

// GET SELECTED OBJECT NAME
var object = obj[selected_object_type,selected_object_position]
var object_name = is_undefined(object) ? "" : object_get_name(object.index);

if global.level_maker_mouse_x >- 16 and global.level_maker_mouse_x < room_width + 16 {
	var object_name_x = (160 + global.level_maker_mouse_x * 3) / 4;
	
	draw_text(object_name_x, -20, object_name);
}


// HOVER TEXT
if instance_exists(oPause) {
	if global.level_maker_mouse_x < room_width / 2 {
		draw_set_halign(fa_left)
		draw_text_shadow(global.level_maker_mouse_x + 14, global.level_maker_mouse_y, hover_text, text_shadow_x, text_shadow_y, color.nice_black);
	} else {
		draw_set_halign(fa_right)
		draw_text_shadow(global.level_maker_mouse_x - 7, global.level_maker_mouse_y, hover_text, text_shadow_x, text_shadow_y, color.nice_black);
	}
}

// CURSOR
draw_set_halign(fa_left)
draw_sprite(sCursor,cursor,global.level_maker_mouse_x,global.level_maker_mouse_y)
