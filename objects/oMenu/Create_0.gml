wavevar=0
maker=false
scr_inputcreate()

//SETUP MENUS
if os_type= os_windows or os_type= os_linux or os_type= os_macosx  { //desktop
	menus = {
		main: [
			{
				name: "start",
				text: function() { return LANG.text_start; },
				action: function() {
					///if (oCamera.debug) { room_goto(RoomMenu4); exit; }
					if (!instance_exists(oTransition)) {
						audio_play_sfx(sndStarGame,false,-6,0)
						var _trans = instance_create_layer(0,0,layer,oTransition);
						audio_play_sfx(sndStarGame,false,-6.2,0)
						if (oCamera.arcade) {
							instance_create_layer(x,y,layer,oTimeAttack);
							_trans.target_room = Room0;
						}
						else {
							
							_trans.target_room = Room100;
						}
					}
				}
			},
			{
				name: "options",
				text: function() { return LANG.text_options; },
				action: function() {
					menu = menus.options;
					option_index = 0;
				}
			},
			{
				name: "credits",
				text: function() { return LANG.text_credits; },
				action: function() {
					if (!instance_exists(oTransition)) {
						audio_play_sfx(sndStarGame,false,-6,0)
						var _trans = instance_create_layer(0,0,layer,oTransition);
						_trans.target_room = RoomCreditsAlves;
					}
				}
			},
			{
				name: "level maker",
				text: function() { return LANG.maker_name; },
				action: function() {
					if (!instance_exists(oTransition)) {
						audio_play_sfx(sndStarGame,false,-6,0)
						var _trans = instance_create_layer(0,0,layer,oTransition);
						_trans.target_room = RoomMaker0;
					}
				}
			},
			{
				name: "exit",
				text: function() { return LANG.text_exit; },
				action: function() {
					game_end()
				}
			}
		],
		options: [
			{
				name: "vibrate",
				text: function() { return LANG.text_vibrate+string(round(global.settings.vibration*100))+"%"; ; },
				action: function() {
					global.settings.vibration+= 0.1;
					if (global.settings.vibration > 1) { global.settings.vibration = 0;}
					shake_gamepad(0.75,10)
				
				}
			},
			{
				name: "soundvideo",
				text: function() { return LANG.text_soundvideo; },
				action: function() {
					menu = menus.soundvideo;
					option_index = 0;
				}
			},
			{
				name: "assist",
				text: function() { return LANG.text_assist; },
				action: function() {
					menu = menus.assist;
					option_index = 0;
				}
			},
			{
				name: "language",
				text: function() { 
					return LANG.text_language+lang_get();
				},
				action: function() {
					var _langs = ["EN","PT-BR","JA","ES","IT","ZH"]; //set language order
					var _lang_index = array_find_index_of_value(_langs,lang_get()); //find position of current
					_lang_index++; //go to next
					if (_lang_index >= array_length(_langs)) { _lang_index = 0; } //wrap around
				
					lang_set(_langs[_lang_index]); //update current language				 
				}
			},
			{
				name: "delete save",
				text: function() { return LANG.text_deletesave; },
				action: function() {
					menu = menus.deletesure;
					option_index = 0;
				}
			},
			{
				name: "back",
				text: function() { return LANG.text_back; },
				action: function() {
					menu = menus.main;
					option_index = 0;
					oSaveManager.save = true;
				}
			},
			
		],
		assist: [
			{
				name: "colorblind",
				text: function() { return LANG.text_colorblind+(global.settings.filter ? LANG.text_ON : LANG.text_OFF); },
				action: function() {
					global.settings.filter = !global.settings.filter;
				}
			},
			{
				name: "gamespeed",
				text: function() { return LANG.text_speed+string(global.settings.gamespd)+"%"; },
				action: function() {
					global.settings.gamespd -= 10;
					if (global.settings.gamespd <= 40) { global.settings.gamespd = 100;}
					game_set_speed((global.settings.gamespd/100)*60,gamespeed_fps)
				}
			},
			{
				name: "back",
				text: function() { return LANG.text_back; },
				action: function() {
					menu = menus.options;
					option_index = 0;
				}
			},
		],
		soundvideo: [
			{		
				name: "music",
				text: function() { return LANG.text_music+(global.settings.bgm_volume ? LANG.text_ON : LANG.text_OFF); },
				action: function() {
					bgm_set_volume(!global.settings.bgm_volume);
				}
			},
			{
				name: "sfx",
				text: function() { return LANG.text_sfx+(global.settings.enable_sfx ? LANG.text_ON : LANG.text_OFF); },
				action: function() {
					global.settings.enable_sfx = !global.settings.enable_sfx;
				}
			},
			{
				name: "fullscreen",
				text: function() { return LANG.text_fullscreen+(window_get_fullscreen() ? LANG.text_ON : LANG.text_OFF); },
				action: function() {
					global.settings.fullscreen = !global.settings.fullscreen;
					window_set_fullscreen(global.settings.fullscreen) ;
					window_set_size(320*global.settings.window_scale,180*global.settings.window_scale)
				}
			},
			{
				name: "windowscale",
				text: function() { return LANG.text_windowscale+"x"+string(global.settings.window_scale); },
				action: function() {
					global.settings.window_scale  += 1;
					if (global.settings.window_scale  > 5) { global.settings.window_scale = 1;}
					window_set_size(320*global.settings.window_scale,180*global.settings.window_scale)
				}
			},
			{
				name: "back",
				text: function() { return LANG.text_back; },
				action: function() {
					menu = menus.options;
					option_index = 0;
				}
			},
		],
		deletesure: [
		{		
				name: "sure?",
				text: function() { return LANG.text_sure;},
				action: function() {
					//thats right, nothing
				}
		},
		{		
				name: "yes",
				text: function() { return LANG.text_yes; },
				action: function() {
					with (oSaveManager) {first_save=true event_user(1);}
					audio_play_sfx(sfx_luano_death_pause_01,false,-8.79,5)
					oCamera.shake=2
					menu = menus.main;
					option_index = 0;
				}
			},
			{
				name: "no",
				text: function() { return LANG.text_no; },
				action: function() {
					menu = menus.options;
					option_index = 0;
				}
			}
		]
	}
}

if os_type= os_switch {  //consoles
	menus = {
		main: [
			{
				name: "start",
				text: function() { return LANG.text_start; },
				action: function() {
					///if (oCamera.debug) { room_goto(RoomMenu4); exit; }
					if (!instance_exists(oTransition)) {
						audio_play_sfx(sndStarGame,false,-6,0)
						var _trans = instance_create_layer(0,0,layer,oTransition);
						if (oCamera.arcade) {
							instance_create_layer(x,y,layer,oTimeAttack);
							_trans.target_room = Room0;
						}
						else {
							_trans.target_room = Room100;
						}
					}
				}
			},
			{
				name: "options",
				text: function() { return LANG.text_options; },
				action: function() {
					menu = menus.options;
					option_index = 0;
				}
			},
			{
				name: "credits",
				text: function() { return LANG.text_credits; },
				action: function() {
					if (!instance_exists(oTransition)) {
						audio_play_sfx(sndStarGame,false,-6,0)
						var _trans = instance_create_layer(0,0,layer,oTransition);
						_trans.target_room = RoomCreditsAlves;
					}
				}
			},
		],
		options: [
			{		
				name: "music",
				text: function() { return LANG.text_music+(global.settings.bgm_volume ? LANG.text_ON : LANG.text_OFF); },
				action: function() {
					bgm_set_volume(!global.settings.bgm_volume);
		
				}
			},
			{
				name: "sfx",
				text: function() { return LANG.text_sfx+(global.settings.enable_sfx ? LANG.text_ON : LANG.text_OFF); },
				action: function() {
					global.settings.enable_sfx = !global.settings.enable_sfx;
				}
			},
			{
				name: "vibrate",
				text: function() { return LANG.text_vibrate+string(round(global.settings.vibration*100))+"%"; ; },
				action: function() {
					global.settings.vibration+= 0.1;
					if (global.settings.vibration > 1) { global.settings.vibration = 0;}
					shake_gamepad(0.75,10)
				}
			},

			{
				name: "assist",
				text: function() { return LANG.text_assist; },
				action: function() {
					menu = menus.assist;
					option_index = 0;
				}
			},
			{
				name: "language",
				text: function() { 
					return LANG.text_language+lang_get();
				},
				action: function() {
						var _langs = ["EN","PT-BR","JA","ES","IT","ZH"]; //set language order
					var _lang_index = array_find_index_of_value(_langs,lang_get()); //find position of current
					_lang_index++; //go to next
					if (_lang_index >= array_length(_langs)) { _lang_index = 0; } //wrap around
				
					lang_set(_langs[_lang_index]); //update current language				 
				}
			},
			{
				name: "delete save",
				text: function() { return LANG.text_deletesave; },
				action: function() {
					menu = menus.deletesure;
					option_index = 0;
				}
			},
			{
				name: "back",
				text: function() { return LANG.text_back; },
				action: function() {
					menu = menus.main;
					option_index = 0;
					oSaveManager.save = true;
				}
			},
		],
		assist: [
			{
				name: "colorblind",
				text: function() { return LANG.text_colorblind+(global.settings.filter ? LANG.text_ON : LANG.text_OFF); },
				action: function() {
					global.settings.filter = !global.settings.filter;
				}
			},
			{
				name: "gamespeed",
				text: function() { return LANG.text_speed+string(global.settings.gamespd)+"%"; },
				action: function() {
					global.settings.gamespd -= 10;
					if (global.settings.gamespd <= 40) { global.settings.gamespd = 100;}
					game_set_speed((global.settings.gamespd/100)*60,gamespeed_fps)
				}
			},
			{
				name: "back",
				text: function() { return LANG.text_back; },
				action: function() {
					menu = menus.options;
					option_index = 0;
				}
			},
		],
		deletesure: [
		{		
				name: "sure?",
				text: function() { return LANG.text_sure;},
				action: function() {
					//thats right, nothing
				}
		},
		{		
				name: "yes",
				text: function() { return LANG.text_yes; },
				action: function() {
					with (oSaveManager) {first_save=true event_user(1);}
					audio_play_sfx(sfx_luano_death_pause_01,false,-8.79,5)
					oCamera.shake=2
					menu = menus.main;
					option_index = 0;
				}
			},
			{
				name: "no",
				text: function() { return LANG.text_no; },
				action: function() {
					menu = menus.options;
					option_index = 0;
				}
			}
		]
	}
}

if os_type= os_ios or os_type= os_android {  //mobile
	menus = {
		main: [
			{
				name: "start",
				text: function() { return LANG.text_start; },
				action: function() {
					///if (oCamera.debug) { room_goto(RoomMenu4); exit; }
					if (!instance_exists(oTransition)) {
						audio_play_sfx(sndStarGame,false,-6,0)
						var _trans = instance_create_layer(0,0,layer,oTransition);
						if (oCamera.arcade) {
							instance_create_layer(x,y,layer,oTimeAttack);
							_trans.target_room = Room0;
						}
						else {
							_trans.target_room = Room100;
						}
					}
				}
			},
			{
				name: "options",
				text: function() { return LANG.text_options; },
				action: function() {
					menu = menus.options;
					option_index = 0;
				}
			},
			{
				name: "credits",
				text: function() { return LANG.text_credits; },
				action: function() {
					if (!instance_exists(oTransition)) {
						audio_play_sfx(sndStarGame,false,-6,0)
						var _trans = instance_create_layer(0,0,layer,oTransition);
						_trans.target_room = RoomCreditsAlves;
					}
				}
			},
		],
		options: [
			{		
				name: "music",
				text: function() { return LANG.text_music+(global.settings.bgm_volume ? LANG.text_ON : LANG.text_OFF); },
				action: function() {
					bgm_set_volume(!global.settings.bgm_volume) ; if oCamera.hubaudiocol!=noone { with(oCamera.hubaudiocol) {hub=true scr_hubchange()} }
				}
			},
			{
				name: "sfx",
				text: function() { return LANG.text_sfx+(global.settings.enable_sfx ? LANG.text_ON : LANG.text_OFF); },
				action: function() {
					global.settings.enable_sfx = !global.settings.enable_sfx;
				}
			},
			{
				name: "buttons",
				text: function() { return LANG.text_buttons+string(global.settings.buttons)+"%"; },
				action: function() {
					global.settings.buttons -= 25;
					if (global.settings.buttons < 0) { global.settings.buttons = 100;}
					
					obDirection.image_alpha=	global.settings.buttons/100
					obJump.image_alpha=			global.settings.buttons/100
					oBpause.image_alpha=		global.settings.buttons/100
				}
			},

			{
				name: "assist",
				text: function() { return LANG.text_assist; },
				action: function() {
					menu = menus.assist;
					option_index = 0;
				}
			},
			{
				name: "language",
				text: function() { 
					return LANG.text_language+lang_get();
				},
				action: function() {
					var _langs = ["EN","PT-BR","JA","ES","IT","ZH"]; //set language order
					var _lang_index = array_find_index_of_value(_langs,lang_get()); //find position of current
					_lang_index++; //go to next
					if (_lang_index >= array_length(_langs)) { _lang_index = 0; } //wrap around
				
					lang_set(_langs[_lang_index]); //update current language				 
				}
			},
			{
				name: "delete save",
				text: function() { return LANG.text_deletesave; },
				action: function() {
					menu = menus.deletesure;
					option_index = 0;
				}
			},
			{
				name: "back",
				text: function() { return LANG.text_back; },
				action: function() {
					menu = menus.main;
					option_index = 0;
					oSaveManager.save = true;
				}
			},
		],
		assist: [
			{
				name: "colorblind",
				text: function() { return LANG.text_colorblind+(global.settings.filter ? LANG.text_ON : LANG.text_OFF); },
				action: function() {
					global.settings.filter = !global.settings.filter;
				}
			},
			{
				name: "gamespeed",
				text: function() { return LANG.text_speed+string(global.settings.gamespd)+"%"; },
				action: function() {
					global.settings.gamespd -= 10;
					if (global.settings.gamespd <= 40) { global.settings.gamespd = 100;}
					game_set_speed((global.settings.gamespd/100)*60,gamespeed_fps)
				}
			},
			{
				name: "back",
				text: function() { return LANG.text_back; },
				action: function() {
					menu = menus.options;
					option_index = 0;
				}
			},
		],
		deletesure: [
		{		
				name: "sure?",
				text: function() { return (LANG.text_sure)},
				action: function() {
					//thats right, nothing
				}
		},
		{		
				name: "yes",
				text: function() { return LANG.text_yes; },
				action: function() {
					with (oSaveManager) {first_save=true event_user(1);}
					audio_play_sfx(sfx_luano_death_pause_01,false,-8.79,5)
					oCamera.shake=2
					menu = menus.main;
					option_index = 0;
				}
			},
			{
				name: "no",
				text: function() { return LANG.text_no; },
				action: function() {
					menu = menus.options;
					option_index = 0;
				} 
			}
		]
	}
}

menu = menus.main; //set current menu
option_index = 0; //currently selected option index
option = menu[option_index]; //currently selected option struct

	
	obDirection.image_alpha=	global.settings.buttons/100
	obJump.image_alpha=			global.settings.buttons/100
	oBpause.image_alpha=		global.settings.buttons/100