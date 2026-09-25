event_inherited();

night = oCamera.night;

switch(oLevelMaker.selected_style) {
	case LEVEL_MAKER_STYLE.GRASS:		sprite_index = sGrassGre;	break;
	case LEVEL_MAKER_STYLE.CLOUDS:	sprite_index = sCloudDay;	break;
	case LEVEL_MAKER_STYLE.FLOWERS:	sprite_index = sFlowerDay;	break;
	case LEVEL_MAKER_STYLE.SPACE:		sprite_index = sSpaceGre;	break;
	case LEVEL_MAKER_STYLE.DUNGEON:	sprite_index = sDunDay;		break;
}

if night then image_index = 2;