snail = instance_place(x, y + 2, oSnailGray);
//bat=instance_place(x,y+2,oBat)
//batver = instance_place(x, y + 1, oBatVer);

image_index=random_range(0,2)
neww=true
night=false
hsp=0
vsp=0

if instance_exists(oLevelMaker) {
	switch(oLevelMaker.selected_style) {
		case LEVEL_STYLE.FLOWERS:
		case LEVEL_STYLE.SPACE:
		case LEVEL_STYLE.DUNGEON:
			sprite_index = sStarFlower;
			break;
	}
} else if instance_exists_any([oFlowerDay, oSpaceDay, oDunDay]) {
	sprite_index = sStarFlower;
}

// new movement code

jumped = false;
landed = false;

platform_target = 0;
wall_target     = 0;

on_ground_var = has_collided(0, 1);

// Used for sub-pixel movement
cx = 0;
cy = 0;

c_left    = place_meeting(x - 1, y, oSolid);
c_right   = place_meeting(x + 1, y, oSolid);
sticking = false
