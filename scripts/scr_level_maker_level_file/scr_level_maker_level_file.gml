function LevelMakerFileData() constructor {
  version = LEVEL_MAKER_SAVE_SYSTEM_VERSION;
  name = "my level";
  author = "my name";
  record_time = -1;
  player_score = -1;
  perfect_score = 0;
  use_night_music = false;
  style = LEVEL_MAKER_STYLE.GRASS;
  objects = [];
  tiles = [];
};

/// @desc Opens a level file and returns the level data extracted from it.
/// @param {string} _level_file_path The path that points to the level file.
/// @return {Struct.LevelMakerFileData}
function level_maker_level_file_open(_level_file_path) {
  var _level_json = "",
	    _file = file_text_open_read(_level_file_path);
	
  while not file_text_eof(_file) {
		_level_json += file_text_read_string(_file);
	}
	file_text_close(_file);
  _level_json = base64_decode(_level_json);
  
  return json_parse(_level_json);
};

/// @desc Saves the given level data to the given directory path.
/// @param {string} _level_file_path The path to save the level data with the file name and extension.
/// @param {Struct.LevelMakerFileData} _level_data The data to save into the file.
function level_maker_level_file_save(_level_file_path, _level_data) {
  var _file_name = _level_file_path;
  var _json = json_stringify(_level_data);
  
  _json = base64_encode(_json);
  if file_exists(_file_name) {
    file_delete(_file_name);
  }
  
  var _file = file_text_open_write(_file_name);
  
  file_text_write_string(_file, _json);
  file_text_close(_file);
}

/// @desc Checks whether the given level file name has a valid extension.
/// @param {string} _level_file_name Level file name.
function level_maker_is_level_file_extension_valid(_level_file_name) {
  var _filename_split = string_split(_level_file_name, ".", true);
          
  return _filename_split[array_length(_filename_split) - 1] == LEVEL_MAKER_LEVEL_FILE_EXTENSION;
}