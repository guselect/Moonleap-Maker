drawtarget = 0;

if not instance_exists(oPause) {
	exit;
}

if oLevelMaker.current_layer == LEVEL_CURRENT_LAYER.OBJECTS {
    with(oLevelMaker) {
        other.object = obj[selected_object_type, other.index];
    }
	
	is_active = not is_undefined(object);

	visible = is_active;
	sprite_index = not is_active ? -1 : object_get_sprite(object.index);
} else {
    with(oLevelMaker) {
        other.tile = tiles[selected_object_type, other.index];
    }
	
	is_active = not is_undefined(tile) or tile <= 0;
	visible = is_active;
	sprite_index = -1;
}

xx = round(xstart - 8)
yy = round(ystart - 8)

x = xx;
y = yy;

if sprite_xoffset > 6 {
	x = xx + 8;
}

if sprite_yoffset > 6 {
	y = yy + 8;
}

if is_active and point_in_rectangle(global.level_maker_mouse_x,global.level_maker_mouse_y,xstart-12,ystart-32,xstart+12,ystart+32) {
    if mouse_check_button_pressed(mb_left) {
        audio_play_sfx(sndUiChange, false, -18.3 ,1);
        with(oLevelMaker) {
            selected_object_position = other.index;
            cursor = LEVEL_CURSOR_TYPE.FINGER;
            image_xscale = 1;
            image_yscale = 1;
            image_angle = 0;
            update_current_item();
        }
    }
}

scale = 1;

switch(sprite_index) {
	case sGemFly:
	case sGemGrayUI:
		y = yy + 3;
		break;
	case sBird:
		y = yy + 16;
		break;
	case sTestDay:
	case sTestNight:
		y = yy;
		x = xx;
		scale = 1;
		break;
}

var _selected_layer = oLevelMaker.current_layer;

if (_selected_layer == LEVEL_CURRENT_LAYER.OBJECTS
	and object == oLevelMaker.obj[oLevelMaker.selected_object_type, oLevelMaker.selected_object_position]
) or (_selected_layer != LEVEL_CURRENT_LAYER.OBJECTS
	and tile == oLevelMaker.tiles[oLevelMaker.selected_object_type, oLevelMaker.selected_object_position]
) {
	drawtarget = -2;
}

drawplus = smooth_approach(drawplus, drawtarget, 0.25);