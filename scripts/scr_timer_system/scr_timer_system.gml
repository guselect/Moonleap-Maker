/// @desc A timer system struct that gives the functionality to decrease time frame by frame by a given amount.
function FrameTimer(_initial_time) constructor {
	__time = _initial_time;
	__initial_time = _initial_time;
	__decrease_amount = 1;
	
	/// @desc Decreases the timer by the decrease amount value.
	count = function() {
		__time = max(__time - __decrease_amount, 0);
	}
	
	/// @desc Sets the time to the initial time.
	reset = function() {
		__time = __initial_time;
	}
	
	/// @desc Sets the decrease amount value. The higher the value, fastest is the time decreasing. 
	/// It must be a value equal or greater than 0. Default speed: 1
	/// @param {real} _decrease_amount The number to be subtracted from the time when the count is performed.
	set_decrease_amount = function(_decrease_amount) {
		__decrease_amount = max(_decrease_amount, 0);
	}
	
	/// @desc Sets a new current time.
	/// @param {real} _time The time to be set.
	set_time = function(_time) {
		__time = _time;
	}
	
	/// @desc Gets the current time value.
	get_time = function() {
		return __time;
	}
	
	/// @desc Gets the initial time.
	get_initial_time = function() {
		return __initial_time;
	}
	
	/// @desc Gets the current decrease amount value.
	get_decrease_amount = function() {
		return __decrease_amount;
	}
	
	/// @desc Gets the time progress. The value can be from 0 to 1.
	get_progress = function() {
		return 1 - (__time / __initial_time);
	}
	
	/// @desc Returns true if the time ran out, otherwise false.
	has_timed_out = function() {
		return __time == 0;
	}
}

/// @desc A timer system struct that gives the functionality to decrease time by delta time.
function DeltaTimer(_initial_time): FrameTimer(_initial_time) constructor {
	__decrease_amount = undefined;
	__speed = 1;
	
	/// @desc Decreases the timer by delta time in real seconds.
	count = function() {
		__time = max(__time - ((delta_time / 1000000) * __speed), 0);
	}
	
	/// @ignore
	set_decrease_amount = function(_decrease_amount) {
		throw "set_decrease_amount only works on Frame Timers.";
	}
	
	/// @desc Sets the timer speed. The higher the value, fastest is the time decreasing.
	/// It must be a value equal or greater than 0. Default speed: 1
	set_speed = function(_speed) {
		__speed = max(_speed, 0);
	}
	
	/// @ignore
	get_decrease_amount = function() {
		throw "get_decrease_amount only works on Frame Timers.";
	}
	
	/// @desc Gets the current speed value
	get_speed = function() {
		return __speed;
	}
}
