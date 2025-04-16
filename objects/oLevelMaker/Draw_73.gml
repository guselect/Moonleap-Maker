// Sprite placeholders for oSolid day and night
var sday = undefined, snight = undefined;

switch(selected_style) {
	case LEVEL_STYLE.GRASS:
		sday = sGrassGre; snight = sGrassOre;
		break;
	case LEVEL_STYLE.CLOUDS:	
		sday = sCloudDay; snight = sCloudNight;
		break;
	case LEVEL_STYLE.FLOWERS:	
		sday = sFlowerDay; snight = sFlowerNight;
		break;
	case LEVEL_STYLE.SPACE:	
		sday = sSpaceGre; snight = sSpacePurple;
		break;
	case LEVEL_STYLE.DUNGEON:
		sday = sDunDay; snight = sDunNight;
		break;
}

//I used to draw only the inner part of the sprite, but that caused bugs with the nine-slice scaling of these sprites
//with (oSolidDay) {
//	draw_sprite(sday,0,x,y)
//}

//with (oSolidNight) {
//	draw_sprite(snight,0,x,y)
//}

//with (oBlack) {
//	draw_sprite(sBlack,0,x,y)
//}

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
draw_sprite(sCursor, cursor, global.level_maker_mouse_x, global.level_maker_mouse_y);