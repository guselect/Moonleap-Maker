if room_is(skip_rooms) {
	exit;
}

if prevroom != room {
	drawname = 9;
}

if oCamera.deathcount == 10 and room_is([Room1, Room2, Room3, Room4, Room5]) {
	drawskip = 9;
}