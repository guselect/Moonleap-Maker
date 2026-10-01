/// @description This function makes the gamepad vibrate.
/// @param {real} _vibration_intensity The vibration intensity to be applied on gamepad.
/// @param {real} _duration_frames The vibration duration in frames per second.
function shake_gamepad(_vibration_intensity, _duration_frames) {
	oCamera.shaketime = _duration_frames;
	
	if (os_type == os_switch) {
		_vibration_intensity *= global.settings.vibration / 2;
		gamepad_set_vibration(global.switch_controller_id, _vibration_intensity, _vibration_intensity);
	} else {
		_vibration_intensity *= global.settings.vibration;
		gamepad_set_vibration(0, _vibration_intensity, _vibration_intensity);
		gamepad_set_vibration(1, _vibration_intensity, _vibration_intensity);
	}
}
