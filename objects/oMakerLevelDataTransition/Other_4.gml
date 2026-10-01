if room_is(RoomMaker0) {
  // INFO: When on RoomMaker0, it needs to wait a bit before loading the level.
  // If it loads the level at the instant this room is started, it will
  // cause bug on the Maker screen.
  alarm[0] = 10;
}
