scr_inputget();

duration_frames = max(-1, duration_frames - 1);
input_interval_frames = max(-1, input_interval_frames - 1);

if (key_jump or key_start or mouse_check_button_pressed(mb_left)) and input_interval_frames == -1 and duration_frames >= 0 {
  duration_frames = -1;
}

if duration_frames == -1 {
  message_duration_frames = max(0, message_duration_frames - 1);
}
if message_duration_frames == 0 {
  instance_destroy();
}
