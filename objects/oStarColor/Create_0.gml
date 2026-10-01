init_movement_variables();

v_max_fall = 4;
v_grav = 0.125;

image_index = random_range(0, 2);
neww = true;
night = false;

platform_target = 0;
wall_target     = 0;

on_ground_var = has_collided(0, 1);