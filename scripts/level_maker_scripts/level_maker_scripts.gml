#macro SAVE_SYSTEM_VERSION "1.0"

function save_level(_level_name) {
	
	with(oLevelMaker){
		
		//var _file_name = "Levels\\" + string(_level_name) + ".moonlevel";
		
		var _file_name = string(_level_name)
		
		//-----------------------------------------------------------------------------------------
		//
		// MAKE A DEEP COPY OF THE OBJECT_GRID ARRAY AND REPLACE OBJECT INDEX WITH OBJECT ASSET NAME
		//
		//-----------------------------------------------------------------------------------------
		var _level_data = [];
		
		//loop through all the objs in level maker
		for(var _x = 0; _x < room_tile_width; _x++){
			for(var _y = 0; _y < room_tile_height; _y++){
				
				var _val = object_grid[_x, _y];
				
				var _data_copy = [];
				
				if(is_array(_val)){
					_data_copy = [
						_val[0],
						_val[1],
						object_get_name(_val[2]),
						_val[3],
						_val[4],
						_val[5],
						_val[6],
					];
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
			level_data: _level_data
		};
		
		var _json = json_stringify(_save);
		
		var _file = file_text_open_write(_file_name);
		file_text_write_string(_file, _json);
		file_text_close(_file);
	}
	
	//game_save(_file_name);
}

function load_level(_level_name){
	
	with(oLevelMaker){
		
		//var _file_name = "Levels\\" + string(_level_name) + ".moonlevel";
		
			var _file_name = string(_level_name)
	
	
		if(!file_exists(_file_name)){
			show_message(_file_name + " does not exist");
			return;
		}
	
		//read json from file
		var _json_string = "";
		var _file = file_text_open_read(_file_name);
		while(!file_text_eof(_file)){
			_json_string += file_text_read_string(_file);
		}
		file_text_close(_file);
	
		var _loaded_data = json_parse(_json_string);
	
		if(_loaded_data.version == SAVE_SYSTEM_VERSION){
			
			object_grid =  _loaded_data.level_data;
	
			for(var _x = 0; _x < room_tile_width; _x++){
				for(var _y = 0; _y < room_tile_height; _y++){
				
					var _save_object = object_grid[@ _x,_y];
				
					//replace object names with indexes
					if(is_array(_save_object)){
						var _object_index = asset_get_index(_save_object[2]);
					
						object_grid[@ _x,_y][@ 2] = _object_index;
					}
				}
			}
		} else {
		
			show_message("THIS SAVE USES AN OLDER SAVE VERSION");
		}
	
	}
	/*for(var _i = 0; _i < array_length(_loaded_data); _i++){
		
		//object data from save file
		var _object = _loaded_data[_i];
		
		var _object_type = asset_get_index(_object.name);
		
		instance_create_layer(_object.x,_object.y,"Instances",_object_type,{
			image_xscale: _object.xscale,
			image_angle: _object.angle,
		});
	}*/
	//game_load(_file_name)
}

function scr_update_style(){
	instance_destroy(oGrassDay);
	instance_destroy(oCloudDay) 
	instance_destroy(oFlowerDay);
	instance_destroy(oSpaceDay);
	instance_destroy(oDunDay)
	
	switch(style_selected) {
		case LEVEL_STYLE.GRASS:		instance_create_layer(-64,-64,layer,oGrassDay);		break;
		case LEVEL_STYLE.CLOUDS:	instance_create_layer(-64,-64,layer,oCloudDay);		break;
		case LEVEL_STYLE.FLOWERS:	instance_create_layer(-64,-64,layer,oFlowerDay);	break;
		case LEVEL_STYLE.SPACE:		instance_create_layer(-64,-64,layer,oSpaceDay);		break;
		case LEVEL_STYLE.DUNGEON:	instance_create_layer(-64,-64,layer,oDunDay);		break;
	}
	
	for (var yy = maxy; yy>=0; yy-=1) {
		for (var xx = maxx; xx>=0; xx-=1) {
			with(obj[xx,yy]) {
				palette_index = oLevelMaker.style_selected;
			}
		}
	}
}