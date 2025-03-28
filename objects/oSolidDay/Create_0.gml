/// @description Insert description here
// You can write your code in this editor
night=oCamera.night
ani=0

switch(oLevelMaker.selected_style) {
	case LEVEL_STYLE.GRASS:		sprite_index = sGrassGre;	break;
	case LEVEL_STYLE.CLOUDS:	sprite_index = sCloudDay;	break;
	case LEVEL_STYLE.FLOWERS:	sprite_index = sFlowerDay;	break;
	case LEVEL_STYLE.SPACE:		sprite_index = sSpaceGre;	break;
	case LEVEL_STYLE.DUNGEON:	sprite_index = sDunDay;		break;
}

if night then image_index = 2;