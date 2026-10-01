function level_maker_save_update_player_score(_level_file_path, _player_score) {
  try {
  	if not file_exists(_level_file_path) {
      show_debug_message("Couldn't open the level file to update the player's score. Updating data level skipped.");
  		return;
  	}
    
    var _loaded_data = level_maker_level_file_open(_level_file_path);
    
    _loaded_data.player_score = _player_score;
    
    level_maker_level_file_save(_level_file_path, _loaded_data);
    show_debug_message("Player score updated successfully!");
  } catch (_error) {
    show_debug_message("[!!!] Failed to update player score.");
  	show_debug_message(_error);
  }
}

function level_maker_save_update_record_time(_level_file_path, _record_time) {
  try {
  	if not file_exists(_level_file_path) {
      show_debug_message("Couldn't open the level file to update the player's record time. Updating data level skipped.");
  		return;
  	}
    
    var _loaded_data = level_maker_level_file_open(_level_file_path);
    
    _loaded_data.record_time = _record_time;
    
    level_maker_level_file_save(_level_file_path, _loaded_data);
    show_debug_message("Player record time updated successfully!");
  } catch (_error) {
    show_debug_message("[!!!] Failed to update player record time.");
  	show_debug_message(_error);
  }
}
