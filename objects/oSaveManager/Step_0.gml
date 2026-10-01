if (save==true)
{
	struct_main.filter=global.settings.filter;
	struct_main.enable_sfx=global.settings.enable_sfx;
	struct_main.enable_bgm=global.settings.bgm_volume;
	struct_main.gamespd=global.settings.gamespd;
	struct_main.deaths=global.settings.deaths;
	struct_main.language=lang_get();
	struct_main.vibration=global.settings.vibration;
	struct_main.fullscreen=global.settings.fullscreen;
	struct_main.window_scale=global.settings.window_scale;
	struct_main.buttons=global.settings.buttons;
	
	array_set(array_data, 0, struct_main);
	
	save=false;
	var string_data = json_stringify(array_data);
	string_envio_google = string_data;
	var buffer_data = buffer_create(string_byte_length(string_data) +1, buffer_fixed, 1);
	buffer_write( buffer_data, buffer_string, string_data);
	buffer_save( buffer_data, "save.moon");
	
	if instance_exists(oPauseUI) //save sometimes
	{
	buffer_save( buffer_data, "savebackup.moon");
	}
	
	buffer_delete(buffer_data);
	if (os_type == os_switch) { switch_save_data_commit(); }
	show_debug_message("game saved step" +  string_data);
	
	if(struct_main[$ "r21"] != "0.0"){
		if(!steam_get_achievement("MN_LEVEL_32")){steam_set_achievement("MN_LEVEL_32")}
		GooglePlayServices_Achievements_Unlock("CgkIo9m7npseEAIQEA");
	}


	if(struct_main[$ "r0"] >=1)
	{
		if(!steam_get_achievement("MN_PIGEON_1")){steam_set_achievement("MN_PIGEON_1")}
		GooglePlayServices_Achievements_Unlock("CgkIo9m7npseEAIQBw");
	}
	
	scr_salva_dados();

}


if (load==true)
{
	event_user(0);
}

