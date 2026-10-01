switch(state) { 
  case states.OUT:
		if transition_sprite_current_frame < transition_sprite_frames + transition_sprites_x {
			transition_sprite_current_frame += transition_sprite_frame_speed;
		} else {
		  state = states.IN;
		  if room_exists(target_room) {
        room_goto(target_room);
      }
    }
	break;

	case states.IN:
   	if transition_sprite_current_frame > 0 {	
      if title_display_interval == 0 {
        transition_sprite_current_frame -= transition_sprite_frame_speed;
      }
   	} else {
      instance_destroy();
    }
	break;
}

if title_display_interval == 0 {
  level_name_display_interval -= 1;
  skip_message_display_interval -= 1;
}

if level_name_display_interval > 0 and level_name_display_interval == 5 and title_display_interval == 0 {
	title_display_interval = title_display_wait;
}

if skip_message_display_interval > 0 and skip_message_display_interval == 5 and title_display_interval == 0 {
	title_display_interval = title_display_with_skip_wait;
}

title_display_interval = approach(title_display_interval, 0, 1);

if room_is(Room100) {
	if instance_exists(oPlayer) {
    nice_black = (oPlayer.y < room_height / 2) ? c_black : COLOR_NICE_BLACK;
	}
} else {
  // Update volume during fade in.
  bgm_set_volume(global.settings.bgm_volume); 
}

