enum INTRO_CONFIRM_SKIP { WAITING_FOR_INPUT, WAITING_FOR_CONFIRM, CONFIRMED };

scr_inputcreate();

yy = 180;
time = -6;
sindex = sguselect;

sure = -1;
confirm_skip = INTRO_CONFIRM_SKIP.WAITING_FOR_INPUT;

skip_timer = new FrameTimer(180);

text = "";

text_color = c_branco2;
nice_white = make_color_rgb(170, 255, 255);
go = true;

confirm_skip_is = function(_confirm_value) {
	return confirm_skip == _confirm_value;
}
