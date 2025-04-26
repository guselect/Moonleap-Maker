startindex = image_index;
night = false;

sindex = sBlockRampMask;

if instance_exists(oFlowerDay)
or instance_exists(oSpaceDay)
or instance_exists(oDunDay) {
	sindex = sBlockRampMaskDark;
}


if room == Room100 {
	if y < room_height / 2
	or (x < 1180 and y < 540) {
		sindex = sBlockRampMaskDark;
	}
}