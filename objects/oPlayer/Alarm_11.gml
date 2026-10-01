/// @description Player sanding still achievement

if not instance_exists(oPauseUI)
{
	if not room_is([RoomMenu, RoomMenu2, RoomFinal, RoomCredits, RoomCreditsAlves, RoomProgress]) {
    if (not steam_get_achievement("MN_STOPPED")) {
      steam_set_achievement("MN_STOPPED")
    }
  }
	GooglePlayServices_Achievements_Unlock("CgkIo9m7npseEAIQEg");
}
