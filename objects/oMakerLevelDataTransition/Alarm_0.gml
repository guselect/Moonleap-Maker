/// @desc Load level

if level_filename != "" and level_filename != undefined {
  level_maker_load(level_filename);
}
if is_true_test {
  oLevelMaker.mode = LEVEL_MAKER_EDITOR_MODE.PLAYING;
  oLevelMaker.start_level();
}
instance_destroy();
