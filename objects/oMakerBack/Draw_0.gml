if not instance_exists(oLevelMaker) then exit;

var background;

switch(oLevelMaker.mode) {
    case LEVEL_EDITOR_MODE.EDITING:
        background = oCamera.night ? sBackNight : sBackDay;
        break;
    
    default:
        background = oCamera.night ? sBackLightNight : sBackLightDay;
        break;
}

draw_sprite_tiled(background, oLevelMaker.selected_style, 0, 0);