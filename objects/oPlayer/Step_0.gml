ghost = PlayerIdle == sGhost;

check_on_landing();

was_on_ground = has_collided(0, 1);

if key_left {
	key_right = false;
}

if state.event_exists("step") {
    state.step();
}

if state.transition_exists("t_tr", state.get_current_state()) {
	state.trigger("t_tr");
}

if debug_mode and keyboard_check_pressed(ord("O")) {
	var skin = 1;
	repeat(7) {
		if skin != 6 {
			struct_set(oSaveManager.struct_main, $"s{skin}", 1);
		}
		skin++;
	}
}
