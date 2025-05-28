scr_inputcreate();

xs = x;
ys = y;
level_name = "";
d_levelName = "";
load_name = "";
d_loadLevel = "";
holding=0
drawy=0
drawx=0
scale=1
cleared_level = false;

start_pos_x = x;
start_pos_y = y;
//if(image_index == 6){
//}

small_size = 20;

drawplus=0
drawtarget=0
hover_text = "";

play_sound_on_press = function() {
	audio_play_sfx(sndUiChange, false, -18.3, 1);
}

change_style = function() {
  with(oLevelMaker) {
		selected_object_type = 0;
		selected_object_position = 0;
		
		selected_style += 1;
		if selected_style >= LEVEL_STYLE.LENGTH then 
			selected_style = 0;
			
		tiles = level_maker_get_tiles_list(selected_style);

		scr_update_style();
    update_current_item();
    reset_level_tiles_grid();
	}
}