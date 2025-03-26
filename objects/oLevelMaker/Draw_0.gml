// Draw every tile on the level maker
if(instance_exists(oPause)) {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++){
			//draw_sprite(spr_ghostfish_3,0,_x*8,_y*8);
			var _xx = _x * 8;
			var _yy = _y * 8;
			var _val = objects_grid[_x,_y];
		
			if(is_array(_val) and _val[0] == _x and _val[1] == _y){
				var _obj = _val[2];
				var _obj_angle = _val[6];
			
				var _sprite = object_get_sprite(_obj.index);
			
				var _object_width = 1;
				var _object_height = 1;
				var _sprite_offset_x = sprite_get_xoffset(_sprite);
				var _sprite_offset_y = sprite_get_yoffset(_sprite);

				var _size = _obj.get_size(tile_size);
			
				_sprite_offset_x = _size[2];
				_sprite_offset_y = _size[3];
				
				_object_width = _size[0];
				_object_height = _size[1];
			
				var _new_offset = rotate_object_offset(_object_width,_object_height,_sprite_offset_x,_sprite_offset_y,_obj_angle);

				_sprite_offset_x = _new_offset[0];
				_sprite_offset_y = _new_offset[1];

				draw_sprite_ext(_sprite,0,_xx + _sprite_offset_x,_yy + _sprite_offset_y , _val[5], 1, _val[6], c_white,1);
			}
		}	
	}
}


draw_set_color(c_white)
draw_set_font(fntSmall)

// Background
draw_sprite(sPauseMaker,0,0,0)

// Draw item preview on cursor
if cursor != LEVEL_CURSOR_TYPE.ERASER and is_cursor_inside_level and instance_exists(oPause) {
	if sprite_exists(sprite_index) {
		draw_sprite_ext(sprite_index, 0, x + item_preview_offset_x, y + item_preview_offset_y, image_xscale, image_yscale, image_angle, c_white, 0.5);
	} else {
		draw_text_shadow(x + 4, y, "?", text_shadow_x, text_shadow_y, color.nice_black);
	}
}

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

with (oSolidDay)
{
	draw_sprite(sday,0,x,y) //I used to draw only the inner part of the sprite, but that caused bugs with the nine-slice scaling of these sprites
}
with (oSolidNight)
{
	draw_sprite(snight,0,x,y)
}

with (oBlack)
{
	draw_sprite(sBlack,0,x,y)
}