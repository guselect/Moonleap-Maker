var nice_black = COLOR_NICE_BLACK
var nice_white = COLOR_NICE_WHITE
var nice_blue = COLOR_NICE_BLUE

// Draw background
if title_display_interval != 0 {
  draw_clear(nice_black)
}

// Draw transition fading
for (var yy = 0; yy <= transition_sprites_y; ++yy) {
	for (var xx = 0; xx <= transition_sprites_x; ++xx) {
    var _sprite = transition_sprite,
        _frame = min(max(0, transition_sprite_current_frame - xx), transition_sprite_frames - 1),
        _x = xx * transition_sprite_height,
        _y = yy * transition_sprite_height,
        _xscale = 1,
        _yscale = 1,
        _rotation = 0,
        _blend = nice_black,
        _alpha = 1;
    
		draw_sprite_ext(_sprite, _frame, _x, _y, _xscale, _yscale, _rotation, _blend, _alpha);
	}
}

nox_set_alternative_color(nice_blue, "#");

// Draw the right color to display the level name.
if level_name_display_interval > 6 or level_name_display_interval < 5 {
  draw_set_color(nice_blue);
} else {
  draw_set_color(nice_white);
}

// Draw the the level name.
if level_name_display_interval > 0
{
  var roomname = string(LANG[$ room_get_name(room)]);
  
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_nox(320 / 2, 180 / 2, roomname, 0, 12, 320, false, 1);
}

// Draw the right color to display the skip message.
if skip_message_display_interval > 6 or skip_message_display_interval < 5 {
  draw_set_color(nice_blue)
} else {
  draw_set_color(nice_white)
}

// Draw the the skip message.
if skip_message_display_interval > 0 {
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(320 / 2, 180 / 2, LANG.text_skip);
}
