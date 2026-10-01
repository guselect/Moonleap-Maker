#macro LEVEL_MAKER_LAYER_FOREGROUND_TILES_NAME "Tiles_Foreground"
#macro LEVEL_MAKER_LAYER_FOREGROUND_ASSETS_NAME "Assets_Foreground"
#macro LEVEL_MAKER_LAYER_FOREGROUND_INSTANCES_NAME "Instances_Foreground"

#macro LEVEL_MAKER_LAYER_BACKGROUND1_TILES_NAME "Tiles_Background1"
#macro LEVEL_MAKER_LAYER_BACKGROUND1_ASSETS_NAME "Assets_Background1"
#macro LEVEL_MAKER_LAYER_BACKGROUND1_INSTANCES_NAME "Instances_Background1"

#macro LEVEL_MAKER_LAYER_BACKGROUND2_TILES_NAME "Tiles_Background2"
#macro LEVEL_MAKER_LAYER_BACKGROUND2_ASSETS_NAME "Assets_Background2"
#macro LEVEL_MAKER_LAYER_BACKGROUND2_INSTANCES_NAME "Instances_Background2"

enum LEVEL_MAKER_LAYERS { FOREGROUND, OBJECTS, BACKGROUND_1, BACKGROUND_2 }

function level_maker_get_decoration_layers() {
  return {
    tiles: [
      layer_get_id(LEVEL_MAKER_LAYER_FOREGROUND_TILES_NAME),
  		layer_get_id(LEVEL_MAKER_LAYER_BACKGROUND1_TILES_NAME),
  		layer_get_id(LEVEL_MAKER_LAYER_BACKGROUND2_TILES_NAME),
    ],
    assets: [
  		layer_get_id(LEVEL_MAKER_LAYER_FOREGROUND_ASSETS_NAME),
  		layer_get_id(LEVEL_MAKER_LAYER_BACKGROUND1_ASSETS_NAME),
  		layer_get_id(LEVEL_MAKER_LAYER_BACKGROUND2_ASSETS_NAME),
  	],
    instances: [
  		layer_get_id(LEVEL_MAKER_LAYER_FOREGROUND_INSTANCES_NAME),
  		layer_get_id(LEVEL_MAKER_LAYER_BACKGROUND1_INSTANCES_NAME),
  		layer_get_id(LEVEL_MAKER_LAYER_BACKGROUND2_INSTANCES_NAME),
  	],
    names: {
      get_tile_name: function(_current_layer) {
        switch(_current_layer) {
      		case LEVEL_MAKER_LAYERS.FOREGROUND:
      			return LEVEL_MAKER_LAYER_FOREGROUND_TILES_NAME;
      		case LEVEL_MAKER_LAYERS.BACKGROUND_1:
      			return LEVEL_MAKER_LAYER_BACKGROUND1_TILES_NAME;
      		case LEVEL_MAKER_LAYERS.BACKGROUND_2:
      			return LEVEL_MAKER_LAYER_BACKGROUND2_TILES_NAME;
      		default:
      			return -1;
      	}
      },
      get_instance_name: function(_current_layer) {
        switch(_current_layer) {
      		case LEVEL_MAKER_LAYERS.FOREGROUND:
      			return LEVEL_MAKER_LAYER_FOREGROUND_INSTANCES_NAME;
      		case LEVEL_MAKER_LAYERS.BACKGROUND_1:
      			return LEVEL_MAKER_LAYER_BACKGROUND1_INSTANCES_NAME;
      		case LEVEL_MAKER_LAYERS.BACKGROUND_2:
      			return LEVEL_MAKER_LAYER_BACKGROUND2_INSTANCES_NAME;
      		default:
      			return -1;
      	}
      }
    }
  }
}

function level_maker_get_layer_hover_text() {
	switch(oLevelMaker.current_layer) {
		case LEVEL_MAKER_LAYERS.FOREGROUND:
			return LANG.maker_foreground;	//"1: Frente (Decoração)";
		case LEVEL_MAKER_LAYERS.OBJECTS:
			return LANG.maker_objects;		//"2: Objetos";
		case LEVEL_MAKER_LAYERS.BACKGROUND_1:
			return LANG.maker_background;	//"3: Fundo (Decoração)";
		case LEVEL_MAKER_LAYERS.BACKGROUND_2:
			return LANG.maker_far_background;//"4: Fundo Distante (Decoração)";
		default:
			return "undefined";
	}
}