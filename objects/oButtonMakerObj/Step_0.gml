/// @description Insert description here
// You can write your code in this editor
drawtarget=0

if !instance_exists(oPause) {exit}



obj=oLevelMaker.obj[oLevelMaker.selected_object_type,index]

var active = obj != oUndefined;

visible = active;

sprite_index=object_get_sprite(obj)

xx=round(xstart-8)
yy=round(ystart-8)


x=xx
y=yy

if sprite_xoffset>6 
{
x=xx+8
}


if sprite_yoffset>6 
{
y=yy+8
}

if active 
	and point_in_rectangle(global.level_maker_mouse_x,global.level_maker_mouse_y,xstart-12,ystart-32,xstart+12,ystart+32)
	and oLevelMaker.cursor != LEVEL_CURSOR_TYPE.ERASER
{
	oLevelMaker.cursor = LEVEL_CURSOR_TYPE.FINGER;
}

if mouse_check_button(mb_left) and point_in_rectangle(global.level_maker_mouse_x,global.level_maker_mouse_y,xstart-12,ystart-32,xstart+12,ystart+32)
{
	if mouse_check_button_pressed(mb_left){audio_play_sfx(sndUiChange,false,-18.3,1);}
	oLevelMaker.selected_object_position = index;
	oLevelMaker.cursor = LEVEL_CURSOR_TYPE.FINGER;
	
}

scale=1
if  sprite_get_height(sprite_index)>30  {scale=0.5 }
if  sprite_get_width(sprite_index)>30	{scale=0.5 }
if  sprite_get_width(sprite_index)>50	{scale=0.4 }
if  sprite_get_width(sprite_index)>60	{scale=0.3 }

if sprite_index=sGemFly or sprite_index=sGemGrayUI {y=yy+3}
if sprite_index=sBird {y=yy+16}
if sprite_index=sTestDay or sprite_index=sTestNight {y=yy x=xx scale=1}


if obj=oLevelMaker.obj[oLevelMaker.selected_object_type,oLevelMaker.selected_object_position] {drawtarget=-2}
drawplus=smooth_approach(drawplus,drawtarget,0.25)