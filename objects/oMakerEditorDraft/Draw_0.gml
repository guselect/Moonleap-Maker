/// @desc Draw draft preview on editor
if not is_in_editor() {
    sprite_index = -1;
    exit;
}

switch(type) {
    case DRAFT_TYPE.TILE:
        var _tile = get_tile_transformed();
        var _alpha = 1;
        
        draw_set_color(c_white);
        draw_set_alpha(_alpha);
        draw_tile(tileset, _tile, 0, x, y);
        draw_set_color(-1);
        break;
    case DRAFT_TYPE.ANIMATED_TILE:
        if sprite_index != -1 then
            draw_sprite_ext(sprite_index, image_index, x + 8, y + 8, xscale, yscale, angle, image_blend, image_alpha);
        break;
}

//draw_set_color(-1);
//draw_text(bbox_right, bbox_bottom, $"{sprite_get_name(sprite_index)}");