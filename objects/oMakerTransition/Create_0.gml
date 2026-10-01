show_title = false;
title = "";
subtitle = "";
room_target = noone;
transition_background_color = COLOR_NICE_BLACK;
on_end_fade_out = undefined;

transition_sprite_index = sTrans;
transition_sprite_width = sprite_get_width(transition_sprite_index);
transition_sprite_height = sprite_get_height(transition_sprite_index);
transition_sprite_frames_count = sprite_get_number(transition_sprite_index);
transition_sprite_amount_x = GUI_W div sprite_get_width(transition_sprite_index);
transition_sprite_amount_y = GUI_H div sprite_get_height(transition_sprite_index);

transition_animation_current_frame = 0;
transition_animation_frame_increment = sprite_get_speed(transition_sprite_index);

title_wait_interval = 150;
title_wait_interval_step = 1;

state_machine = new SnowState("fade_out");

state_machine.add("fade_out", {
  step: function() {
    if transition_animation_current_frame < transition_sprite_frames_count + transition_sprite_amount_x {
			transition_animation_current_frame += transition_animation_frame_increment;
		} else {
      var _next_state = show_title ? "display_title" : "fade_in";

      if room_target != noone and room != room_target {
        room_goto(room_target);
      }
  		state_machine.change(_next_state);
  	}
  },
  draw_gui: function() {
    draw_transition_animation();
  },
  leave: function() {
    if is_method(on_end_fade_out) {
      on_end_fade_out();
    }
  }
});

state_machine.add("display_title", {
  step: function() {
    title_wait_interval = approach(title_wait_interval, 0, title_wait_interval_step);
    
    if title_wait_interval <= 0 {
      state_machine.change("fade_in");
    }
  },
  draw_gui: function() {
    draw_background();
    draw_title();
    draw_subtitle();
  }
});

state_machine.add("fade_in", {
  step: function() {
    transition_animation_current_frame -= transition_animation_frame_increment;
    if transition_animation_current_frame <= 0 {	
      instance_destroy();
  	}
  },
  draw_gui: function() {
    draw_transition_animation();
  }
});

draw_background = function() {
  draw_clear(transition_background_color);
};

draw_transition_animation = function() {
  for (var yy = 0; yy <= transition_sprite_amount_y; ++yy) {
  	for (var xx = 0; xx <= transition_sprite_amount_x; ++xx) {
      var _sprite = transition_sprite_index,
          _frame = clamp(transition_animation_current_frame - xx, 0, transition_sprite_frames_count - 1),
          _x = xx * transition_sprite_width,
          _y = yy * transition_sprite_height,
          _xscale = 1,
          _yscale = 1,
          _angle = 0,
          _color = transition_background_color,
          _alpha = 1;
      
  		draw_sprite_ext(_sprite, _frame, _x, _y, _xscale, _yscale, _angle, _color, _alpha)
  	}
  }
};

draw_title = function() {
  var _title_halign = fa_center,
      _title_valign = fa_middle,
      _title_height = string_height(title),
      _title_x = GUI_W / 2,
      _title_y = GUI_H / 2 - _title_height / 2,
      _title_text = title,
      _title_color = COLOR_NICE_WHITE,
      _title_letters_distance = 0,
      _title_line_distance = 12,
      _title_line_width = GUI_W,
      _title_break_on_space = false,
      _title_alpha = 1;
  
	draw_set_halign(_title_halign);
	draw_set_valign(_title_valign);
  draw_set_color(_title_color);
  draw_set_font(oCamera.font);

	draw_text_nox(
    _title_x,
    _title_y,
    _title_text,
    _title_letters_distance,
    _title_line_distance,
    _title_line_width,
    _title_break_on_space,
    _title_alpha
  );
  
  draw_reset();
};

draw_subtitle = function() {
  var _subtitle_halign = fa_center,
      _subtitle_valign = fa_middle,
      _subtitle_height = string_height(subtitle),
      _subtitle_x = GUI_W / 2,
      _subtitle_y = GUI_H / 2 + _subtitle_height / 2,
      _subtitle_text = subtitle,
      _subtitle_color = COLOR_NICE_WHITE,
      _subtitle_letters_distance = 0,
      _subtitle_line_distance = 12,
      _subtitle_line_width = GUI_W,
      _subtitle_break_on_space = false,
      _subtitle_alpha = 1;
  
	draw_set_halign(_subtitle_halign);
	draw_set_valign(_subtitle_valign);
  draw_set_color(_subtitle_color);
  draw_set_font(oCamera.font);

	draw_text_nox(
    _subtitle_x,
    _subtitle_y,
    _subtitle_text,
    _subtitle_letters_distance,
    _subtitle_line_distance,
    _subtitle_line_width,
    _subtitle_break_on_space,
    _subtitle_alpha
  );
  
  draw_reset();
};