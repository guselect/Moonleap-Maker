enum states { OUT, IN };

state = states.OUT;

rooms_to_skip = [RoomMenu, RoomMenu2, RoomMakerMenu, RoomMaker0, RoomProgress, RoomCredits, RoomCreditsAlves, Room100];

title_display_wait = 150;
title_display_with_skip_wait = 175;

title_display_interval = 0;
level_name_display_interval = 0;
skip_message_display_interval = 0;

target_room = noone;

previous_room = room;
oCamera.previous_room = room_get_name(previous_room);

//if instance_exists(oLevelMaker) {
	//switch(oLevelMaker.selected_style) {
		//case LEVEL_MAKER_STYLE.FLOWERS:
		//case LEVEL_MAKER_STYLE.SPACE:
		//case LEVEL_MAKER_STYLE.DUNGEON:
			//nice_black = c_black;
			//break;
	//}
//} else if instance_exists(oFlowerDay) or instance_exists(oSpaceDay) or instance_exists(oDunDay) {
	//nice_black = c_black;
//}

nice_black = COLOR_NICE_BLACK;

if room_is(Room100) and (
  (instance_exists(oPlayer) and oPlayer.y < room_height / 2)
  or (instance_exists(oDead) and oDead.y < room_height / 2)
) {
  nice_black = c_black;
}

transition_sprite = sTrans;
transition_sprite_width = sprite_get_width(transition_sprite); 
transition_sprite_height = sprite_get_height(transition_sprite);

transition_sprites_x = 320 div transition_sprite_width;
transition_sprites_y = 190 div transition_sprite_height;

transition_sprite_frames = sprite_get_number(transition_sprite);
transition_sprite_frame_speed = sprite_get_speed(transition_sprite);
transition_sprite_current_frame = 0;

if layer_exists("Instances_2") {
  layer = layer_get_id("Instances_2");
}