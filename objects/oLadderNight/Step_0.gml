/// @description Insert description here
// You can write your code in this editor
if night {
	palette_index = startpal;
	mask_index = sprite_index;
} else {
	palette_index = 6;
	mask_index = sEmpty;
}

if startpal == 2 {
	if night {
		palette_index = startpal;
		mask_index = sprite_index;
	} else {
		palette_index = 7;
		mask_index = sEmpty;
	}	
}