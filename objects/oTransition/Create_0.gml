/// @description Insert description here
// You can write your code in this editor

//show_debug_message(string(instance_number(object_index)))
//if(instance_number(object_index)>1){instance_destroy();}
 layer=layer_get_id("Instances_2")

pause=0

enum states {

OUT,
IN
}

state = states.OUT;

spr = sTrans;
sprw = sprite_get_width (spr); 
sprh = sprite_get_height (spr);

//get number of sprites required
//set max sprites for x
xmax = 320 div sprw;
//set max sprites for y
ymax=190 div sprh;
imax=sprite_get_number(spr);

//set image_speed
sub_image_index_inc_ini = sprite_get_speed(spr) 
sub_image_index_inc = sprite_get_speed(spr) 
sub_image_index = 0;

//transition colour
col = make_color_rgb(0,0,72)

//target room
target_room = noone;
drawname=0
drawskip=0

prevroom=room

if instance_exists(oLevelMaker) {
	switch(oLevelMaker.selected_style) {
		case LEVEL_STYLE.FLOWERS:
		case LEVEL_STYLE.SPACE:
		case LEVEL_STYLE.DUNGEON:
			col = c_black;
			nice_black = c_black;
			break;
	}
} else if instance_exists(oFlowerDay) or instance_exists(oSpaceDay) or instance_exists(oDunDay) {
	col = c_black;
	nice_black=c_black
}

oCamera.previous_room=room_get_name(room)

nice_black=make_color_rgb(0,0,72)


if room=Room100
{
	if instance_exists(oPlayer)
	{
	if oPlayer.y<room_height/2 { nice_black=c_black}
	}
	
		if instance_exists(oDead)
	{
	if oDead.y<room_height/2 { nice_black=c_black}
	}
}

//if solid=true
//{
//audio_sound_gain(bgm_hub   ,0,1000)
//audio_sound_gain(bgm_hub_01,0,1000)
//audio_sound_gain(bgm_hub_02,0,1000)
//audio_sound_gain(bgm_hub_03,0,1000)
//audio_sound_gain(bgm_hub_04,0,1000)
//
//}

wait=0
