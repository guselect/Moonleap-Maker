ghost = PlayerIdle == sGhost;

check_on_landing();

was_on_ground = has_collided(0, 1);

if key_left {
	key_right = false
}

if state.event_exists("step") {
    state.step();
}

if state.transition_exists("t_tr", state.get_current_state()) {
	state.trigger("t_tr");
}

//check_change_by_direction();
//set_movement_x();
//set_jump();

////if not has_collided(0, 1) {
//    //state = PLAYER_STATE.JUMP;
////}

//set_animation_speed();
////set_sprite_animation();
//set_footstep_sound();
//set_game_paused();
//set_rope_swinging();

//check_collected_stars();
//check_destroy_itself();
//check_ceiling_collision();
//check_ladder_collision();
//check_day_night_spikes_collision();
//check_snail_spike_collision();
//check_wall_squash_collision();
//check_star_collision();
//check_perma_spike_collision();
//check_mushroom_collision();