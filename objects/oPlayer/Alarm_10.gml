/// @description Level 3 achievement

if instance_exists(oStar) {
	if not steam_get_achievement("MN_LEVEL3") {
    steam_set_achievement("MN_LEVEL3")
  }
  GooglePlayServices_Achievements_Unlock("CgkIo9m7npseEAIQEw");
}
