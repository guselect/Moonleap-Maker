init_movement_variables();

v_max_fall = 4;
v_grav = 0.125;

snail = instance_place(x, y + 2, oSnailGray);

image_index = random_range(0, 2);
neww = true;
night = false;

if instance_exists(oLevelMaker) {
	switch(oLevelMaker.selected_style) {
		case LEVEL_MAKER_STYLE.FLOWERS:
		case LEVEL_MAKER_STYLE.SPACE:
		case LEVEL_MAKER_STYLE.DUNGEON:
			sprite_index = sStarFlower;
			break;
	}
} else if instance_exists_any([oFlowerDay, oSpaceDay, oDunDay]) {
	sprite_index = sStarFlower;
}

platform_target = 0;
wall_target     = 0;

on_ground_var = has_collided(0, 1);
