enum INTRO_CONFIRM_SKIP { WAITING_FOR_INPUT, WAITING_FOR_CONFIRM, CONFIRMED };

scr_inputcreate();

yy = 180;
time = -6;
sindex = sguselect;

sure = -1;
confirm_skip = INTRO_CONFIRM_SKIP.WAITING_FOR_INPUT;
skiptime = 0;

text = "";

text_color = c_branco2;
nice_white = make_color_rgb(170, 255, 255);
go = true;

// *** Change maker_mode to true to skip the intro and redirect to the level maker.
maker_mode = true;

confirm_skip_is = function(_confirm_value) {
	return confirm_skip == _confirm_value;
}
