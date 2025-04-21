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