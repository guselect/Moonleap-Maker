init_movement_variables();

v_max_fall = 4;
v_grav = 0.125;
v_flee = 1;

distance_x_to_flee = 40;
distance_y_to_flee = 10;

image_index = random_range(0, 1);
neww = false;
drawscale = 1;

platform_target = 0;
wall_target = 0;

on_ground_var = has_collided(0, 1);
