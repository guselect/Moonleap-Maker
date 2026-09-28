event_inherited();

night = oCamera.night;

switch(oLevelMaker.selected_style) {
	case LEVEL_MAKER_STYLE.GRASS:		sprite_index = sGrassOre;		break;
	case LEVEL_MAKER_STYLE.CLOUDS:	sprite_index = sCloudNight;		break;
	case LEVEL_MAKER_STYLE.FLOWERS:	sprite_index = sFlowerNight;	break;
	case LEVEL_MAKER_STYLE.SPACE:		sprite_index = sSpacePurple;	break;
	case LEVEL_MAKER_STYLE.DUNGEON:	sprite_index = sDunNight;		break;
}

if not night then image_index = 2;