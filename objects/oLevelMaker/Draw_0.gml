/// @description Insert description here
// You can write your code in this editor

//draw every tile on the level maker
if(instance_exists(oPause)) {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++){
			//draw_sprite(spr_ghostfish_3,0,_x*8,_y*8);
			var _xx = _x*8;
			var _yy = _y*8;
		
			var _val = object_grid[_x,_y];
		
			if(is_array(_val) && _val[0] == _x && _val[1] == _y){
				var _obj_ind = _val[2];
			
				var _obj_angle = _val[6];
			
				var _sprite = object_get_sprite(_obj_ind);
			
				var _object_width = 1;
				var _object_height = 1;
				var _sprite_offset_x = sprite_get_xoffset(_sprite);
				var _sprite_offset_y = sprite_get_yoffset(_sprite);

				var _size = object_to_size[? _obj_ind];
			
				if(_size != undefined){
					_sprite_offset_x = _size[2];
					_sprite_offset_y = _size[3];
				
					_object_width = _size[0];
					_object_height = _size[1];			
				}
			
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

draw_sprite(sPauseMaker,0,0,0)

if cursor != LEVEL_CURSOR_TYPE.ERASER and is_inside_level
{
	if sprite_exists(sprite_index) {
		draw_sprite_ext(sprite_index,0,x+xplus,y+yplus,image_xscale,image_yscale,image_angle,c_white,0.5);
	} else {
		draw_text(x+4,y,"?")
	}
	//draw_sprite(sLevelsb,0,xx,yy)
}

//draw_sprite(sLevelsb,0,top_left_x,top_left_y);

//STYLE STUFF, PLACEHOLDER

if style_selected=0{
	var sday=		sGrassGre; var snight=	sGrassOre
}
if style_selected=1{
	var sday=		sCloudDay; var snight=	sCloudNight
}
if style_selected=2{
	var sday=		sFlowerDay; var snight	=sFlowerNight
}
if style_selected=3{
	var sday=		sSpaceGre; var snight=	sSpacePurple
}
if style_selected=4{
	var sday=		sDunDay; var snight=	sDunNight
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