time = 2;
shake = 2;
night = false;
neutral = false;
trueblack = false;

oCamera.shake = 3;
shake_gamepad(1, 20);

if instance_exists(oNeutralFlag) {
    neutral = true;
}

if instance_exists(oLevelMaker) {
    exit;
}

global.settings.deaths += 1;

show_debug_message("MN_DEATH_10 achievement: " + string(steam_get_achievement("MN_DEATH_10")));
show_debug_message("Death counter: " + string(global.settings.deaths));

if(global.settings.deaths >= 10) {
	if not steam_get_achievement("MN_DEATH_10") {
		show_debug_message("10 ou mais mortes registradas.");
		steam_set_achievement("MN_DEATH_10")
		oSaveManager.save = true;
	}
	GooglePlayServices_Achievements_Unlock("CgkIo9m7npseEAIQAQ");
}

if global.settings.deaths >= 100 {
	if(not steam_get_achievement("MN_DEATH_100")){
		steam_set_achievement("MN_DEATH_100");
			oSaveManager.save = true;
	}
	GooglePlayServices_Achievements_Unlock("CgkIo9m7npseEAIQAg");
}