// Sprite placeholders for oSolid day and night
//var sday = undefined, snight = undefined;

//switch(selected_style) {
//	case LEVEL_STYLE.GRASS:
//		sday = sGrassGre; snight = sGrassOre;
//		break;
//	case LEVEL_STYLE.CLOUDS:	
//		sday = sCloudDay; snight = sCloudNight;
//		break;
//	case LEVEL_STYLE.FLOWERS:	
//		sday = sFlowerDay; snight = sFlowerNight;
//		break;
//	case LEVEL_STYLE.SPACE:	
//		sday = sSpaceGre; snight = sSpacePurple;
//		break;
//	case LEVEL_STYLE.DUNGEON:
//		sday = sDunDay; snight = sDunNight;
//		break;
//}

draw_set_color(color.nice_white);

if not instance_exists(oPause) {
	draw_sprite_ext(sPauseMaker,0,0,0,1,1,0,c_white,0.5)
}

draw_set_halign(fa_center)

// GET SELECTED OBJECT NAME
if current_layer == LEVEL_CURRENT_LAYER.OBJECTS {
	var object = obj[selected_object_type,selected_object_position]
	var object_name = is_undefined(object) ? "" : object_get_name(object.index);

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

//draw_set_color(c_yellow);
//draw_rectangle(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, true);
//
//var _x = floor(x / tileset_size) * tileset_size;
//var _y = floor(y / tileset_size) * tileset_size;
//draw_set_color(c_lime);
//draw_rectangle(_x, _y, _x + tileset_size - 1, _y + tileset_size - 1, true);

draw_set_color(-1);
draw_set_halign(-1);