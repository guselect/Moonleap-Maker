function level_maker_is_editing() {
	return instance_exists(oLevelMaker) and oLevelMaker.mode == LEVEL_MAKER_EDITOR_MODE.EDITING;
}

function level_maker_update_style() {
	instance_destroy(oGrassDay);
	instance_destroy(oCloudDay);
	instance_destroy(oFlowerDay);
	instance_destroy(oSpaceDay);
	instance_destroy(oDunDay)
	
	switch(selected_style) {
		case LEVEL_MAKER_STYLE.GRASS:		instance_create_layer(-64, -64, layer, oGrassDay);		break;
		case LEVEL_MAKER_STYLE.CLOUDS:	instance_create_layer(-64, -64, layer, oCloudDay);		break;
		case LEVEL_MAKER_STYLE.FLOWERS:	instance_create_layer(-64, -64, layer, oFlowerDay);		break;
		case LEVEL_MAKER_STYLE.SPACE:		instance_create_layer(-64, -64, layer, oSpaceDay);		break;
		case LEVEL_MAKER_STYLE.DUNGEON:	instance_create_layer(-64, -64, layer, oDunDay);		break;
	}
	
	for (var yy = list_positions_length - 1; yy >= 0; yy -= 1) {
		for (var xx = object_types_length - 1; xx >= 0; xx -= 1) {
			var object = obj[xx,yy];
			
			if is_undefined(object) then continue;

			with(object.index) {
				palette_index = oLevelMaker.selected_style;
			}
		}
	}
}

function level_maker_check_level_validation() {
  return oLevelMaker.has_level_a_player() 
  and oLevelMaker.has_level_a_star();
}
