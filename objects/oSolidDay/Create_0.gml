/// @description Insert description here
// You can write your code in this editor
night=oCamera.night
ani=0

//var sday = undefined, snight = undefined;

//switch(oLevelMaker.selected_style) {
//	case LEVEL_STYLE.GRASS:
//		sday = sGrassGre; snight = sGrassOre;
//		break;
//	case LEVEL_STYLE.CLOUDS:	
//		sday = sCloudDay; snight = sCloudNight;
//		break;
//	case LEVEL_STYLE.FLOWERS:	
//		sday = sFlowerDay; snight = sFlowerNight;
//		break;
//	case LEVEL_STYLE.SPACE:	
//		sday = sSpaceGre; snight = sSpacePurple;
//		break;
//	case LEVEL_STYLE.DUNGEON:
//		sday = sDunDay; snight = sDunNight;
//		break;
//}

switch(oLevelMaker.selected_style) {
	case LEVEL_STYLE.GRASS:		sprite_index = sGrassGre;	break;
	case LEVEL_STYLE.CLOUDS:	sprite_index = sCloudDay;	break;
	case LEVEL_STYLE.FLOWERS:	sprite_index = sFlowerDay;	break;
	case LEVEL_STYLE.SPACE:		sprite_index = sSpaceGre;	break;
	case LEVEL_STYLE.DUNGEON:	sprite_index = sDunDay;		break;
}

if night then image_index = 2;

//image_index = night ? 2 : 0;

//if night {
//	sprite_index = snight;
//	image_index = 2;
//} else {
//	sprite_index = sday;
//	image_index = 0;
//}