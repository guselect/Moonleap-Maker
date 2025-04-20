scr_inputget()

if room != Room100 {
    if x < 0 then x += room_width; 
    if x > room_width then x -= room_width;
    if y < 0 then y += room_height;
    if y > room_height then y -= room_height;
}

numb = approach(numb, 0, 1);

if state == PLAYER_STATE.WIN or instance_exists(oPauseMenu) or numb > 0 {
	key_right = 0;
	key_left = 0;
	key_jump_pressed = 0;
	key_jump = 0;
	key_start = 0;
}

if instance_exists(oTransition) and (oTransition.wait != 0 or room == Room100) {
    key_right = 0;
    key_left = 0;
    key_jump_pressed = 0;
    key_jump = 0;
    key_start = 0;
}

if oCamera.debug and key_reset and debug_mode {
    godmode = not godmode;
    oCamera.show_debug = godmode;
}

if godmode {
	grav = 0;
	if key_jump or key_up then vsp = -4;
	if key_down then vsp = 2;
	if key_left then hsp = -3;
	if key_right then hsp = 3;
}

if key_right + key_left == 2 {
	key_right = 0;
	key_left = 0;
}

//not pressing, holding, star only exists ingame
if key_down_notpressed and was_on_ground {
	down_time += 1;
} else {
	down_time = 0;
}

if down_time >= 30 {
	idletime = 0;
	scr_changeskin();
}
