/// @description Insert description here
// You can write your code in this editor
if on_desktop()
{
window_command_set_active(window_command_close, false);	
}


game_set_speed((global.settings.gamespd/100)*60,gamespeed_fps)
view_enabled=true
view_visible[0] = true;
view_camera[0] = camera_create();

camera_set_view_size(view_camera[0],view_width,view_height)

if instance_exists(oLevelMaker) {
	switch(oLevelMaker.selected_style) {
		case LEVEL_STYLE.FLOWERS:
		case LEVEL_STYLE.SPACE:
		case LEVEL_STYLE.DUNGEON:
			nice_black = c_black;
			break;
	}
} else if instance_exists(oFlowerDay) or instance_exists(oSpaceDay) or instance_exists(oDunDay) {
	nice_black = c_black;
}

if (instance_exists(oLevelMaker) and oLevelMaker.selected_style)
or instance_exists(oDunDay) {
	instance_create_layer(0, 0, "Instances_2", oFog);
}
//if room_height>180
//{y=view_height}else {y=0}

y=0
x=0

shaketime=0
if actualroom!=room {deathcount=0 actualroom=room}

night=false


if room!=RoomMenu and room!=RoomMenu2 and room!=RoomFinal and room!=RoomCredits and room!=RoomCreditsAlves and room!=RoomProgress
{
levelnumb=real(string_digits(room_get_name(room)))
}
else
{
levelnumb=noone //noone
}

if room=Room100
{
		audio_stop_sound(bgm_intro)

	//checkpoint in hub
	if xspawn!=noone and yspawn!=noone
	{
	oPlayer.x=xspawn
	oPlayer.y=yspawn
	x=xcamspawn
	y=ycamspawn
	
	levelnumb=noone //noone
	}
	
	hubx = x div view_width;
	huby = y div view_height;
	hubx_prev = hubx;
	huby_prev = huby;
	
	hubcheck = true;
}
else
{
	audio_stop_sound(bgm_hub)
	audio_stop_sound(bgm_hub_01)
	audio_stop_sound(bgm_hub_02)
	audio_stop_sound(bgm_hub_03)
	audio_stop_sound(bgm_hub_04)
}


if !audio_group_is_loaded(agroup_bgm)
{
    audio_group_load(agroup_bgm);
}

/////////////PARTICLE EFFECTS//////////////////////
if fancyeffects=true
{
	var layerfx_param=
	{
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
	}

	if !layer_exists("Effect_1") {exit;}

	layer_set_fx("Effect_1",parentfx); //APLICA o efeito necessário

	layerfx = layer_get_fx("Effect_1")
	fx_set_parameters(layerfx, layerfx_param); //aplica os parametros corretos

	layer_enable_fx("Effect_2", false) //utilizava 2 camadas de efeitos pras part, mas percebi que n faz sentido custo benefício

	///////////CHANGE THE PART BASED ON LEVEL AND DAY&NIGHT/////////////////////

	if night=true {fx_set_parameter(layerfx,"param_sprite",sDustIntro)} else {fx_set_parameter(layerfx,"param_sprite",sDustIntro)}

	if instance_exists(oSpecial1) {
		if night=true {fx_set_parameter(layerfx,"param_sprite",sDustHUB)} else {fx_set_parameter(layerfx,"param_sprite",sDustHUB)}
	}

	if instance_exists(oGrassDay){
		if night=true {fx_set_parameter(layerfx,"param_sprite",sDustNight)} else {fx_set_parameter(layerfx,"param_sprite",sDUST)}
	}

	if instance_exists(oCloudDay){
		if night=true {fx_set_parameter(layerfx,"param_sprite",sDustNightClouds)} else {fx_set_parameter(layerfx,"param_sprite",sDUST)}
		fx_set_parameter(layerfx, "param_grav_accel",4)
		fx_set_parameter(layerfx, "param_particle_spawn_time  ",999)
		fx_set_parameter(layerfx, "param_blower_force_max",10)
	}

	if instance_exists(oPortal){
	if night=true {fx_set_parameter(layerfx,"param_sprite",sDustHUB)} else {fx_set_parameter(layerfx,"param_sprite",sDustHUB)}
	}

	if instance_exists(oFlowerDay){
		if night=true {fx_set_parameter(layerfx,"param_sprite", sDustNightFlower)} else  {fx_set_parameter(layerfx, "param_sprite",sDustFlower)}
	}

	if instance_exists(oSpaceDay){
		if night=true {fx_set_parameter(layerfx,"param_sprite", sDustNightSpace)} else  {fx_set_parameter(layerfx, "param_sprite",sDustSpace)}
	}

	if instance_exists(oDunDay) or  instance_exists(oDunNight){
		if night=true {fx_set_parameter(layerfx,"param_sprite",sDustNightDun)} else {fx_set_parameter(layerfx,"param_sprite",sDustDun)}
	}
}
else
{
if layer_exists("Effect_1") {layer_destroy(layer_get_id("Effect_1"))}
if layer_exists("Effect_2") {layer_destroy(layer_get_id("Effect_2"))}
}