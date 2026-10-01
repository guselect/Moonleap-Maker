if instance_exists(oPauseUI) {
  exit;
}

sprite_index = night ? sStarDaySpike : sStarDay;

on_ground_var = has_collided(0, 1, true, [oPermaSpike]);

if not on_ground_var and image_angle == 0
{
	vsp += v_grav;
}

vsp = min(vsp, v_max_fall);

object_set_room_wrapping();
