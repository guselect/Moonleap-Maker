if room_is([RoomMaker0]) and instance_exists(oLevelMaker) {
  switch(oLevelMaker.selected_style) {
    case LEVEL_MAKER_STYLE.FLOWERS:
    case LEVEL_MAKER_STYLE.SPACE:
    case LEVEL_MAKER_STYLE.DUNGEON:
      image_index = 1;
    break;
    default:
      image_index = 0;
    break;
  }
}