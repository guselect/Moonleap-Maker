function level_maker_set_fx(_fx_layer_name) {
  var _layer_fx_config = {
		param_particle_spawn_border_prop : 0.25, param_blower_rot_speed_min : -180, param_particle_col_2_pos : 0.33,
		param_trail_col_3_pos : 0.66, param_particle_mass_max : 5, param_trail_thickness_min : 0.15,
		param_debug_grid : 0, param_particle_rot_speed_min : 0, param_num_blowers : 3,
		param_particle_col_alt_3 : [ 1,1,1,1 ], param_trail_col_4 : [ 1,1,1,0 ], param_particle_spawn_time : 100,
		param_particle_align_vel : 1, param_blower_force_max : 20, param_particle_initial_velocity_range_x_max : 10,
		param_trail_dest_blend : 6, param_particle_col_1 : [ 1,1,1,1 ], param_trail_col_alt_1 : [ 1,1,1,0.25 ],
		param_particle_lifetime_max : 100, param_blower_speed_min : 0.20, param_particle_col_enabled_2 : 0,
		param_trail_col_enabled_3 : 0, param_sprite : sDUST, param_trail_lifetime_min : 0.50, param_dragcoeff : 1,
		param_particle_initial_rotation_min : 0, param_wind_vector_x : 0, param_particle_col_alt_2 : [ 1,1,1,1 ],
		param_trail_col_3 : [ 1,1,1,0.10 ], param_particle_src_blend : 5, param_blower_rot_speed_max : 180,
		param_particle_col_3_pos : 0.66, param_trail_min_segment_length : 20, param_particle_start_sprite_scale : 1,
		param_trail_thickness_max : 0.15, param_particle_rot_speed_max : 0, param_blower_size_min : 0.20,
		param_particle_col_4 : [ 1,1,1,1 ], param_trail_col_alt_4 : [ 1,1,1,0 ], param_particle_spawn_all_at_start : 1,
		param_trails_only : 0, param_blower_camvec_scale : -1, param_particle_initial_velocity_range_y_min : -10,
		param_force_grid_sizex : 8, param_particle_col_alt_1 : [ 1,1,1,1 ], param_trail_col_2 : [ 1,1,1,0.10 ],
		param_particle_update_skip : 1, param_blower_speed_max : 0.50, param_particle_col_enabled_3 : 0,
		param_trail_col_2_pos : 0.50, param_particle_mass_min : 4, param_trail_lifetime_max : 1, param_grav_accel : 0,
		param_particle_initial_rotation_max : 0, param_wind_vector_y : 0, param_particle_col_3 : [ 1,1,1,1 ],
		param_trail_col_alt_3 : [ 1,1,1,0.25 ], param_num_particles : 40, param_particle_dest_blend : 6,
		param_blower_force_min : 5, param_particle_initial_velocity_range_x_min : -10, param_trail_src_blend : 5,
		param_particle_end_sprite_scale : 1, param_trail_col_1 : [ 1,1,1,0.10 ], param_particle_lifetime_min : 100,
		param_blower_size_max : 0.60, param_particle_col_alt_4 : [ 1,1,1,1 ], param_trail_col_enabled_2 : 0,
		param_warmup_frames : 0, param_trail_chance : 0, param_particle_initial_velocity_range_y_max : 10,
		param_force_grid_sizey : 8, param_particle_col_2 : [ 1,1,1,1 ], param_trail_col_alt_2 : [ 1,1,1,0.25 ] 
	};
  
  if oLevelMaker.selected_style == LEVEL_MAKER_STYLE.CLOUDS {
    _layer_fx_config[$ "param_grav_accel"] = 4;
    _layer_fx_config[$ "param_particle_spawn_time"] = 999;
    _layer_fx_config[$ "param_blower_force_max"] = 10;
	}
  
  var _layer_fx = layer_get_fx(_fx_layer_name);
  
  layer_clear_fx(_fx_layer_name);
  fx_set_parameters(_layer_fx, _layer_fx_config);
  layer_set_fx(_fx_layer_name, _layer_fx);
}