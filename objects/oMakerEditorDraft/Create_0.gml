enum DRAFT_TYPE { TILE, ANIMATED_TILE }

type = DRAFT_TYPE.TILE;

// Sprite preview config
angle = 0;
xscale = 1;
yscale = 1;

// Tile config
tilemap_id = undefined;
tileset = undefined;
tile_id = -1;

is_rotated = false;
is_mirrored = false;
is_flipped = false;

// Layer config for animated tiles
layer_id = undefined;

// Animated tile config
sprite_day = -1;
sprite_night = -1;
animated_tile_instance = noone;

is_in_editor = function() {
    return instance_exists(oLevelMaker) and oLevelMaker.mode == LEVEL_EDITOR_MODE.EDITING;
}

draw_question_mark = function() {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);            
    draw_text_shadow(x + 8, y + 8, "?", 2, 1, make_color_rgb(0, 0, 72)); 
    draw_set_halign(-1);
    draw_set_valign(-1); 
}

/// @returns {real} Tile ID transformed.
get_tile_transformed = function() {
    var _tile = tile_id;

    _tile = tile_set_rotate(_tile, is_rotated);
    _tile = tile_set_mirror(_tile, is_mirrored);
    _tile = tile_set_flip(_tile, is_flipped);

    return _tile;
}

set_in_room = function() {
    switch(type) {
        case DRAFT_TYPE.TILE:
            if is_undefined(tilemap_id) or tilemap_id == -1 {
                draw_question_mark();
                break;
            }
            var _tile = get_tile_transformed();

            tilemap_set_at_pixel(tilemap_id, _tile, x, y);
            break;

        case DRAFT_TYPE.ANIMATED_TILE:
            animated_tile_instance = instance_create_layer(x + 8, y + 8, layer_id, oMakerAnimatedTile);
            animated_tile_instance.sprite_index = sprite_day;
            animated_tile_instance.image_angle = angle;
            animated_tile_instance.image_xscale = xscale;
            animated_tile_instance.image_yscale = yscale;
            animated_tile_instance.sprite_day = sprite_day;
            animated_tile_instance.sprite_night = sprite_night;
            break;
    }
}

remove_from_room = function() {
    switch(type) {
        case DRAFT_TYPE.TILE:
            tilemap_set_at_pixel(tilemap_id, 0, x, y);
            break;
        case DRAFT_TYPE.ANIMATED_TILE:
            instance_destroy(animated_tile_instance, false);
            break;
    }
}
