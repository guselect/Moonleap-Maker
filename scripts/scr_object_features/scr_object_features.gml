/// @desc Check whether the object is out of the bounds of the current room. If so, it will appear the other side of the axis.
function object_set_room_wrapping() {
	if xstart < 0 or xstart > 320 then return;
	
	if x > room_width {
		x = 0;
	}
	
	if x < 0 {
		x = room_width;
	}
	
	if y > room_height { 
		y = 0;
	}

	if y < 0 {
		y = room_height;
	}
}