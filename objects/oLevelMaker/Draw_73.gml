draw_set_color(nice_white)

if !instance_exists(oPause)
{
	draw_sprite_ext(sPauseMaker,0,0,0,1,1,0,c_white,0.5)
}
//if mouse_x>0 and mouse_x<320
{
	mx=(160+global.level_maker_mouse_x*3)/4
}
draw_set_halign(fa_center)

// var oname = is_undefined(obj[currentx,currenty]) ? "" : object_get_name(obj[currentx,currenty]);
var oname = string_delete(object_get_name(obj[currentx,currenty]), 1, 1);
if oname == "Undefined" then oname = "";

if global.level_maker_mouse_x>-16 and global.level_maker_mouse_x<room_width+16 
{draw_text(mx,-20,oname)}


// HOVER TEXT
if instance_exists(oPause) {
	if global.level_maker_mouse_x < room_width / 2 {
		draw_set_halign(fa_left)
		draw_text(global.level_maker_mouse_x+14,global.level_maker_mouse_y,hover_text)
	} else {
		draw_set_halign(fa_right)
		draw_text(global.level_maker_mouse_x-7,global.level_maker_mouse_y,hover_text)
	}
}

// CURSOR
draw_set_halign(fa_left)
draw_sprite(sCursor,cursor,global.level_maker_mouse_x,global.level_maker_mouse_y)
