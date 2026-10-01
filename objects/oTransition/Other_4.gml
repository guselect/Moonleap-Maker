if room_is(rooms_to_skip) {
	exit;
}

if previous_room != room {
	level_name_display_interval = 9;
}

if oCamera.deathcount == 10 and room_is([Room1, Room2, Room3, Room4, Room5]) {
	skip_message_display_interval = 9;
}