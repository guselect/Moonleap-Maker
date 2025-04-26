instance_create_layer(x, y - 2, "Instances_2", oBigSmoke);
audio_play_sfx(snd_kick, false, -3, 15);
oCamera.shake = 2;
shake_gamepad(0.125,2);
audio_stop_sound(sndPush);