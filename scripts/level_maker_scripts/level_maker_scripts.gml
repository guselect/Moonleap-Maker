#macro SAVE_SYSTEM_VERSION "1.2"

function save_level(_level_name) {
	with(oLevelMaker){
		//-----------------------------------------------------------------------------------------
		//
		// MAKE A DEEP COPY OF THE OBJECT_GRID ARRAY AND REPLACE OBJECT INDEX WITH OBJECT ASSET NAME
		//
		//-----------------------------------------------------------------------------------------
		var _level_data = [];
		
		//loop through all the objs in level maker
		for(var _x = 0; _x < room_tile_width; _x++){
			for(var _y = 0; _y < room_tile_height; _y++){
				
				var _object_grid = objects_grid[_x, _y];
				
				var _data_copy = [];
				
				if is_struct(_object_grid) {
					_data_copy = {
						top_left_x: _object_grid.top_left_x,
						top_left_y: _object_grid.top_left_y,
						object_name: object_get_name(_object_grid.object.index),
						object_width: _object_grid.object_width,
						object_height: _object_grid.object_height,
						xscale: _object_grid.xscale,
						yscale: _object_grid.yscale,
						angle: _object_grid.angle,
					};
				} else {
					_data_copy = -1;
				}
				
				_level_data[_x,_y] = _data_copy;
			}
		}
		//-----------------------------------------------
		
		//save the object data
		
		var _save = {
			version: SAVE_SYSTEM_VERSION,
			level_style: selected_style,
			level_data: _level_data
		};
		
		var _file_name = string(_level_name);
		var _json = json_stringify(_save);
		
		if file_exists(_file_name) {
			file_delete(_file_name)
		}
		
		var _file = file_text_open_write(_file_name);
		file_text_write_string(_file, _json);
		file_text_close(_file);
	}
}

function load_level(_level_name){
	var _file_name = string(_level_name)
	
	if not file_exists(_file_name) {
		show_message(_file_name + " does not exist.");
		return;
	}
	
	// Read json from file
	var _json_string = "";
	var _file = file_text_open_read(_file_name);
	while not file_text_eof(_file) {
		_json_string += file_text_read_string(_file);
	}
	file_text_close(_file);
	
	// All level info parsed
	var _loaded_data = json_parse(_json_string);
		
	if(_loaded_data.version != SAVE_SYSTEM_VERSION) {
		show_message("THIS SAVE USES AN DIFFERENT SAVE VERSION AND CANNOT BE LOADED.");
		return;
	}
	
	with(oLevelMaker) {
		var _level_style = variable_struct_exists(_loaded_data, "level_style") ? _loaded_data.level_style : LEVEL_STYLE.GRASS;
			
		selected_style = _level_style;
		
		for(var _x = 0; _x < room_tile_width; _x++) {
			for(var _y = 0; _y < room_tile_height; _y++) {
				var _loaded_object_grid = _loaded_data.level_data[_x, _y];
					
				if _loaded_object_grid == -1 {
					objects_grid[_x, _y] = -1;
				} else {
					var _object_index = asset_get_index(_loaded_object_grid.object_name);
					var _object = undefined;
						
					for(var t = 0; t < oLevelMaker.object_types_length and is_undefined(_object); t++) {
						for(var p = 0; p < oLevelMaker.list_positions_length and is_undefined(_object); p++) {
							var _object_to_find = oLevelMaker.obj[t, p];
								
							if is_undefined(_object_to_find) then continue;
								
							if _object_to_find.index == _object_index then
								_object = _object_to_find;
						}
					}
						
					if not is_undefined(_object) {
						objects_grid[_loaded_object_grid.top_left_x, _loaded_object_grid.top_left_y] = new LMObjectGrid(
							_loaded_object_grid.top_left_x,
							_loaded_object_grid.top_left_y,
							_object,
							_loaded_object_grid.object_width,
							_loaded_object_grid.object_height,
							_loaded_object_grid.xscale,
							_loaded_object_grid.yscale,
							_loaded_object_grid.angle
						)
					} else {
						objects_grid[_loaded_object_grid.top_left_x, _loaded_object_grid.top_left_y] = -1;
					}
				}
			}
		}
	}
}

function scr_update_style(){
	instance_destroy(oGrassDay);
	instance_destroy(oCloudDay) 
	instance_destroy(oFlowerDay);
	instance_destroy(oSpaceDay);
	instance_destroy(oDunDay)
	
	switch(selected_style) {
		case LEVEL_STYLE.GRASS:		instance_create_layer(-64, -64, layer, oGrassDay);		break;
		case LEVEL_STYLE.CLOUDS:	instance_create_layer(-64, -64, layer, oCloudDay);		break;
		case LEVEL_STYLE.FLOWERS:	instance_create_layer(-64, -64, layer, oFlowerDay);		break;
		case LEVEL_STYLE.SPACE:		instance_create_layer(-64, -64, layer, oSpaceDay);		break;
		case LEVEL_STYLE.DUNGEON:	instance_create_layer(-64, -64, layer, oDunDay);		break;
	}
	
	for (var yy = list_positions_length - 1; yy>=0; yy-=1) {
		for (var xx = object_types_length - 1; xx>=0; xx-=1) {
			var object = obj[xx,yy];
			
			if is_undefined(object) then continue;

			with(object.index) {
				palette_index = oLevelMaker.selected_style;
			}
		}
	}
}