draw_set_font(oCamera.font);
draw_set_color(color.nice_white);

if not level_maker_is_editing() or instance_exists(oPauseMenu) {
	draw_sprite_ext(sPauseMaker,0,0,0,1,1,0,c_white,0.5)
}

draw_set_halign(fa_center)

// GET SELECTED OBJECT NAME
if current_layer == LEVEL_CURRENT_LAYER.OBJECTS {
	var object = obj[selected_object_type,selected_object_position]
	var object_name = is_undefined(object) ? "" : LANG[$ $"maker_object_{object_get_name(object.index)}"];

	var room_x_offset = 16;
	if global.level_maker_mouse_x > -room_x_offset 
		and global.level_maker_mouse_x < room_width + room_x_offset 
	{
		var object_name_x = (160 + global.level_maker_mouse_x * 3) / 4;
	
		draw_text(object_name_x, -20, object_name);
	}
}

// HOVER TEXT
if mode == LEVEL_EDITOR_MODE.EDITING and hover_text != "" {
    var _mouse_x = global.level_maker_mouse_x;
    var _mouse_y = global.level_maker_mouse_y;

	if global.level_maker_mouse_x < room_width / 2 {
		draw_set_halign(fa_left)
		draw_text_shadow(_mouse_x + 14, _mouse_y, hover_text, text_shadow_x, text_shadow_y, color.nice_black);
	} else {
		draw_set_halign(fa_right)
		draw_text_shadow(_mouse_x - 7, _mouse_y, hover_text, text_shadow_x, text_shadow_y, color.nice_black);
	}
}

// CURSOR
draw_set_halign(fa_left)
draw_sprite(sCursor, cursor, global.level_maker_mouse_x, global.level_maker_mouse_y);

draw_set_color(-1);
draw_set_halign(-1);