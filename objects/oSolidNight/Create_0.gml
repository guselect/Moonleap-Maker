/// @description Insert description here
// You can write your code in this editor
night=oCamera.night
ani=0

switch(oLevelMaker.selected_style) {
	case LEVEL_STYLE.GRASS:		sprite_index = sGrassOre;		break;
	case LEVEL_STYLE.CLOUDS:	sprite_index = sCloudNight;		break;
	case LEVEL_STYLE.FLOWERS:	sprite_index = sFlowerNight;	break;
	case LEVEL_STYLE.SPACE:		sprite_index = sSpacePurple;	break;
	case LEVEL_STYLE.DUNGEON:	sprite_index = sDunNight;		break;
}

if not night then image_index = 2;