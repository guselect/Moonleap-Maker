if state_machine.event_exists("step") {
  state_machine.step();
}

bgm_set_volume(global.settings.bgm_volume);