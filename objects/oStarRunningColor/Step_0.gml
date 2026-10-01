if instance_exists(oPauseUI) {
  exit;
}

on_ground_var = has_collided(0, 1, true, [oPermaSpike]);

if not on_ground_var and image_angle == 0 
{
	vsp += v_grav
}

vsp = min(vsp, v_max_fall);

object_set_room_wrapping();

hsp = 0;

var _player = oPlayer;
var _player_x = _player.x;
var _player_y = _player.y;

if not instance_exists(_player)
{
  exit;
}

if not night
{
	sprite_index = sStarDayRun;
	if distance_to_point(x, _player_y) < distance_y_to_flee
	{
  	if distance_to_point(_player_x, _player_y) < distance_x_to_flee
  	{
      hsp = _player_x > x ? -v_flee : v_flee;
  	}
  
  	if distance_to_point(_player_x - room_width, _player_y) < distance_x_to_flee
  	{
      hsp = _player_x - room_width > x ? -v_flee : v_flee;
  	}
  
  	if distance_to_point(_player_x + room_width, _player_y) < distance_x_to_flee
  	{
      hsp = _player_x + room_width > x ? -v_flee : v_flee;
  	}
	}
}
else
{
	
	sprite_index = sStarDaySpikeRun;
	if distance_to_point(x, _player_y) < distance_y_to_chase
	{
    
    if distance_to_point(_player_x, _player_y) < distance_x_to_chase
    {
      hsp = _player_x < x ? -v_chase : v_chase;
    }
    
    if distance_to_point(_player_x - room_width, _player_y) < distance_x_to_chase
    {
      hsp = _player_x - room_width < x ? -v_chase : v_chase;
    }
    
    if distance_to_point(_player_x + room_width, _player_y) < distance_x_to_chase
    {
      hsp = _player_x + room_width < x ? -v_chase : v_chase;
    }
	}
	
	if instance_exists(_player) and distance_to_object(_player) < 4 
  {
    instance_destroy(_player);
  }
}

if hsp > 0
and not (
  place_meeting(x - (sprite_width / 3), y + 1, oSolid) 
  or place_meeting(x - (sprite_width / 3), y + 1, oPlatGhost) 
  or place_meeting(x - (sprite_width / 3), y + 1, oPermaSpike)
) {
  image_xscale = -image_xscale;
  hsp = 0;
}																					    											  

if hsp < 0
and not (
  place_meeting(x - (sprite_width / 3), y + 1, oSolid) 
  or place_meeting(x - (sprite_width / 3), y + 1, oPlatGhost) 
  or place_meeting(x - (sprite_width / 3), y + 1, oPermaSpike)
) {
  image_xscale = -image_xscale;
  hsp = 0;
}
	
if place_meeting(x + hsp, y, oSolid) {
  image_xscale = -image_xscale
  hsp = 0;
}

if hsp != 0 {
  image_xscale = sign(hsp); 
  image_speed = 4;
} else {
  image_speed = 1;
}
