/// @description Insert description here
// You can write your code in this editor
image_index= y / 16;
night = false;

startpal = 0
palette_index = 0

if instance_exists(oGrassDay) {
	palette_index=0;
	startpal = palette_index;
	exit;
}

if instance_exists(oCloudDay) {
	palette_index = 1;
	startpal = palette_index;
	exit;
}

if instance_exists(oFlowerDay) {
	palette_index = 2;
	startpal = palette_index;
	exit;
}

if instance_exists(oSpaceDay) {
	palette_index = 3;
	startpal = palette_index;
	exit;
}

if instance_exists(oDunDay) {
	palette_index = 4;
	startpal = palette_index;
	exit;
}
