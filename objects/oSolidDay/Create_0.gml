/// @description Insert description here
// You can write your code in this editor
night=oCamera.night
ani=0

var sday = undefined, snight = undefined;

switch(style_selected) {
	case LEVEL_STYLE.GRASS:
		sday = sGrassGre; snight = sGrassOre;
		break;
	case LEVEL_STYLE.CLOUDS:	
		sday = sCloudDay; snight = sCloudNight;
		break;
	case LEVEL_STYLE.FLOWERS:	
		sday = sFlowerDay; snight = sFlowerNight;
		break;
	case LEVEL_STYLE.SPACE:	
		sday = sSpaceGre; snight = sSpacePurple;
		break;
	case LEVEL_STYLE.DUNGEON:
		sday = sDunDay; snight = sDunNight;
		break;
}

if night {
	sprite_index = snight;
	image_index = 2;
} else {
	sprite_index = sday;
	image_index = 0;
}