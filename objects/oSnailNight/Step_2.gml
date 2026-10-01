if instance_exists(oPauseUI)
or instance_exists(oDead)
or (instance_exists(oTransition) and oTransition.title_display_wait != 0)
or maker_transition_is_running()
or (instance_exists(oPlayer) and oPlayer.state.state_is("win")) {
	image_speed = 0; 
	exit;
}

image_speed = 1;

apply_movement_collision();
