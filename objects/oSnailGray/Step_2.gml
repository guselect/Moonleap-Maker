if instance_exists(oPauseMenu) 
or instance_exists(oDead)
or (instance_exists(oTransition) and oTransition.wait != 0)
or (instance_exists(oPlayer) and oPlayer.state.state_is("win")) {
	image_speed = 0; 
	exit;
}

image_speed = 1;

var _cx = hsp * on_ground_var + hsp_plus;

// Handle sub-pixel movement
scr_moving_plat(_cx);