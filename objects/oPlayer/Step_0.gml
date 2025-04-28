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
